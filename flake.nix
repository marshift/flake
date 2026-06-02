{
  description = "marsh's NixOS configurations";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-apple-silicon = {
      url = "github:nix-community/nixos-apple-silicon/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs:
    let
      specialArgs = {
        inherit inputs;
        username = "marsh";
      };

      mkSystem = ({
        hostName,
        hostPlatform,
        stateVersion,
        nixosModules ? [],
        homeModules ? [],
      }: inputs.nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        system = hostPlatform;
        modules = builtins.concatLists [
          [
            {
              networking = { inherit hostName; };
              nixpkgs = { inherit hostPlatform; };
              system = { inherit stateVersion; };
            }
            ./modules/nixos/meta/filesystems.nix
            ./modules/nixos/meta/locale.nix
            ./modules/nixos/meta/users.nix
            ./modules/nixos/nix.nix
            ./modules/nixos/home-manager.nix
            ({
              username,
              ...
            }: {
              home-manager = {
                users.${username} = {
                  home = { inherit stateVersion; };
                  imports = homeModules;
                };
                extraSpecialArgs = specialArgs;
              };
            })
          ]
          nixosModules
        ];
      });
      mkSystems = systems: builtins.listToAttrs (map (s: { name = s.hostName; value = mkSystem s; }) systems);
    in {
      nixosConfigurations = mkSystems [
        {
          hostName = "sally"; # Sally Cinnamon, you're my world
          hostPlatform = "aarch64-linux";
          stateVersion = "25.11";
          nixosModules = [
            ./modules/nixos/luks.nix
            ./modules/nixos/systemd-boot.nix
            ./modules/nixos/hardware/apple-silicon.nix
            {
              fileSystems."/boot".device = "/dev/disk/by-uuid/7D4E-1710"; # Assigned by Asahi Linux Installer
              hardware.asahi.peripheralFirmwareDirectory = ./resources/firmware/MacBookAir10-1;
              boot.extraModprobeConfig = ''
                options hid_apple iso_layout=0
              '';
            }
            ./modules/nixos/services/iwd.nix
          ];
          homeModules = [
            ./modules/home/cli/git.nix
          ];
        }
      ];
    };
}
