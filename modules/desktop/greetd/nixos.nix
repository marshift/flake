{
  lib,
  pkgs,
  config,
  ...
}:
lib.modules.mkIf config.swamp.desktop.greetd.enable {
  services.greetd = {
    enable = true;
    restart = true;
    useTextGreeter = true;

    settings.default_session = {
      user = "greeter";
      command = lib.strings.concatStringsSep " " [
        (lib.meta.getExe pkgs.tuigreet)
        "--asterisks"
        "--time"
        "--title"
        "--custom-title ${config.networking.hostName}"
        "--greeting \"Who might you be?\""
        "--width 40"
        "--background doom"
      ];
    };
  };
}
