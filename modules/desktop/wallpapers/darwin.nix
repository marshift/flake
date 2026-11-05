{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.swamp.desktop.wallpapers;

  activePoolDirectories = map (name: cfg.pools.${name}) cfg.activePools;

  daemonName = "marshflake-wallpaper-cycle";

  cycleScript = pkgs.writeShellScript daemonName ''
    set -euo pipefail

    poolDirectories=(
      ${lib.concatMapStringsSep "\n" (d: ''"${d}"'') activePoolDirectories}
    )

    mapfile -t images < <(find -L "''${poolDirectories[@]}" -type f -iname "*.png" -o -iname "*.heic" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" | sort)

    statePath="$HOME/Library/Application Support/marshflake/last-wallpaper"
    mkdir -p "$(dirname "$statePath")"

    lastImagePath=""
    if [ -f "$statePath" ]; then
        lastImagePath=$(cat "$statePath")
    fi

    nextImagePath="''${images[0]}"
    for i in "''${!images[@]}"; do
        if [ "''${images[$i]}" = "$lastImagePath" ]; then
          nextIndex=$(( (i + 1) % ''${#images[@]} ))
          nextImagePath="''${images[$nextIndex]}"
          break
        fi
    done

    printf '%s\n' "$nextImagePath" > "$statePath"

    /usr/bin/osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$nextImagePath\""
  '';
in
lib.modules.mkIf cfg.enable {
  launchd.user.agents.${daemonName} = {
    serviceConfig = {
      ProgramArguments = [ "${cycleScript}" ];
      StartInterval = cfg.cycleInterval;
      RunAtLoad = true;
      StandardOutPath = "/tmp/${daemonName}.out";
      StandardErrorPath = "/tmp/${daemonName}.out";
    };
  };
}
