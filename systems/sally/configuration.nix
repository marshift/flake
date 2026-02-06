{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;

  networking = {
    hostName = "sally"; # Sally Cinnamon, you're my world
    wireless.iwd = {
      enable = true;
      settings.General.EnableNetworkConfiguration = true;
    };
  };

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  users.users.marsh = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    nano
    git
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    extra-substituters = [ "https://nixos-apple-silicon.cachix.org" ];
    extra-trusted-public-keys = [ "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20=" ];
    experimental-features = [ "nix-command" "flakes" ];
  };

  system.stateVersion = "25.11";
}

