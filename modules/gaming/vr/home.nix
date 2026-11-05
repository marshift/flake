{
  inputs,
  lib,
  pkgs,
  config,
  osConfig,
  ...
}:
lib.modules.mkIf (osConfig.swamp.gaming.vr.enable && osConfig.swamp.gaming.steam.enable) {
  xdg.configFile."openvr/openvrpaths.vrpath".text =
    let
      steam = "${config.xdg.dataHome}/Steam";
    in
    lib.strings.toJSON {
      version = 1;
      jsonid = "vrpathreg";

      external_drivers = null;
      config = [ "${steam}/config" ];

      log = [ "${steam}/logs" ];

      runtime = [
        "${inputs.nixpkgs-xr.packages.${pkgs.stdenv.hostPlatform.system}.xrizer}/lib/xrizer"
      ];
    };
}
