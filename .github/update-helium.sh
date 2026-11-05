#!/usr/bin/env bash
set -euo pipefail

HELIUM_PACKAGE_PATH=packages/helium/default.nix

for target in darwin linux
do
    repo_name="helium-$target"
    if [[ $target == "darwin" ]]; then
        repo_name="helium-macos"
    fi

    latest_release=$(curl -s "https://api.github.com/repos/imputnet/$repo_name/releases/latest")
    latest_version=$(echo "$latest_release" | jq -r '.tag_name')

    flake_version=$(grep -oE "$target = \"[^\"]+\";" $HELIUM_PACKAGE_PATH | sed "s/$target = \"//;s/\";//")

    if [[ "$flake_version" == "$latest_version" ]]; then
        continue
    fi

    for arch in x86_64 aarch64
    do
        artifact_arch=$arch
        if [[ $artifact_arch == "aarch64" ]]; then
            artifact_arch="arm64"
        fi

        if [[ $target == "darwin" ]]; then
            download_url="https://github.com/imputnet/$repo_name/releases/download/$latest_version/helium_${latest_version}_${artifact_arch}-macos.dmg"
        else
            download_url="https://github.com/imputnet/$repo_name/releases/download/$latest_version/helium-$latest_version-${artifact_arch}_linux.tar.xz"
        fi

        new_hash=$(nix store prefetch-file --hash-type sha256 --json "$download_url" | jq -r '.hash')
        sed -i "/$arch-$target = {/,/};/s|hash = \".*\";|hash = \"$new_hash\";|" $HELIUM_PACKAGE_PATH
    done

    sed -i "s/$target = \"[^\"]*\";/$target = \"$latest_version\";/" $HELIUM_PACKAGE_PATH
    echo "Updated Helium on $target: $flake_version → $latest_version"
done
