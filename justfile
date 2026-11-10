# TODO: Remote deployments?

flake_dir := env("FLAKE", justfile_dir())
class := if os() == "macos" { "darwin" } else { "nixos" }

[private]
default:
    @just --list --unsorted

rebuild_command := if class == "darwin" { "sudo darwin-rebuild" } else { "nixos-rebuild --sudo" }

[group("rebuild")]
[no-exit-message]
[private]
builder goal host *args:
    {{ rebuild_command }} {{ goal }} --flake {{ flake_dir }}#{{ host }} {{ args }}

# Build the configuration for a given host and activate it, but don't add it to the bootloader menu
[group("rebuild")]
[no-exit-message]
test host=`hostname` *args: (builder "test" host args)

# Build the configuration for a given host and make it the default boot option, but don't activate it until the next reboot
[group("rebuild")]
[no-exit-message]
boot host=`hostname` *args: (builder "boot" host args)

# Build the configuration, activate it, and add it to the bootloader menu
[group("rebuild")]
[no-exit-message]
switch host=`hostname` *args: (builder "switch" host args)

# Spawn a REPL for a given host of a given class
[group("utils")]
[no-exit-message]
repl host=`hostname` class=class:
    nix repl {{ flake_dir }}#{{ class }}Configurations.{{ host }}

# Check the flake for errors
[group("utils")]
[no-exit-message]
check:
    nix flake check --option allow-import-from-derivation false --show-trace {{ flake_dir }}

# Update a given set of flake inputs, or all of them if none are specified
[group("utils")]
[no-exit-message]
update *inputs:
    nix flake update --flake {{ flake_dir }} --refresh {{ inputs }}

# Clean the local Nix store and remove old profiles
[group("utils")]
[no-exit-message]
clean:
    nix-collect-garbage --delete-older-than 3d
    nix store optimise
