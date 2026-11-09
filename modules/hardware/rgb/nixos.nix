{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (pkgs) writeShellScriptBin openrgb;
  inherit (lib.meta) getExe;
  inherit (lib.strings) concatLines escapeShellArg;

  cfg = config.swamp.hardware.rgb;

  baseCommand = "${getExe openrgb} --client 127.0.0.1";
  rgbScript = writeShellScriptBin "rgb" ''
     ${getExe openrgb} --server --noautoconnect &
     server_pid=$!
     trap 'kill "$server_pid" 2>/dev/null || true' EXIT

     sleep 30 # Assume device discovery is done by 30s, ugh

      ${
        concatLines (
          lib.lists.map (
            zone: "${baseCommand} --device ${escapeShellArg zone.device} --zone ${zone.id} --size ${zone.size}"
          ) cfg.resizableARGBZones
        )
      } # Set ARGB zones sizes
    ${baseCommand} --mode direct --color ${cfg.color} # Apply color to all devices
  '';
in
lib.modules.mkIf (cfg.color != null) {
  boot.kernelModules = [ "i2c-dev" ];
  hardware.i2c.enable = true;

  services.udev.packages = [ openrgb ];

  systemd.services.rgb = {
    description = "RGB Devices";

    serviceConfig = {
      Type = "exec";
      ExecStart = getExe rgbScript;
    };
    restartIfChanged = false;

    wantedBy = [ "multi-user.target" ];
  };
}
