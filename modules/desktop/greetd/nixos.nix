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
        "--time"
        "--asterisks"
        "--greeting 'helo, who is you?'"
        "--background matrix"
        "--matrix-colors 'magenta,lightmagenta,red'"
        "--title"
        "--custom-title '${config.networking.hostName}'"
      ];
    };
  };
}
