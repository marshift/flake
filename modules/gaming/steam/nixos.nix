{
  inputs,
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
mkIf config.swamp.gaming.steam.enable {
  # SuspendThread Loop failed SuspendThread Loop failed SuspendThread Loop failed
  boot.kernelModules = [ "ntsync" ];

  programs = {
    steam = {
      enable = true;
      extraCompatPackages = mkIf config.swamp.gaming.vr.enable [
        inputs.nixpkgs-xr.packages.${pkgs.stdenv.hostPlatform.system}.proton-rtsp-bin
      ];
    };

    gamescope.enable = true;
  };

  networking.firewall = {
    allowedTCPPorts = [
      9757
      5353
    ];
    allowedUDPPorts = [
      9757
      5353
    ];
  };
}
