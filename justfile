rebuild-command := if os() == "macos" { "sudo nix --extra-experimental-features nix-command --extra-experimental-features flakes run nix-darwin/master#darwin-rebuild --" } else { "nixos-rebuild" }
rebuild-args := if os() == "macos" { "" } else { "--sudo" }

[group('rebuild')]
[no-exit-message]
switch host=`hostname`:
    {{ rebuild-command }} switch --flake .#{{ host }} {{ rebuild-args }}
