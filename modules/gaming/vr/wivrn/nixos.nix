{
  inputs,
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe;
  inherit (inputs.nixpkgs-xr.packages.${pkgs.stdenv.hostPlatform.system}) wayvr oscavmgr wivrn;

  appsScript = pkgs.writeShellScriptBin "wivrn-apps" ''
    ${getExe wayvr} --wait &
    ${getExe oscavmgr} openxr &
    wait
  '';
in
mkIf config.swamp.gaming.vr.wivrn.enable {
  services.wivrn = {
    package =
      if config.swamp.hardware.gpu.nvidia.enable then (wivrn.override { cudaSupport = true; }) else wivrn;
    enable = true;
    autoStart = true;
    highPriority = true;
    openFirewall = true;

    steam = mkIf config.swamp.gaming.steam.enable {
      enable = true;
      importOXRRuntimes = true;
    };

    config = {
      enable = true;
      json.application = [ appsScript ];
    };
  };
}
