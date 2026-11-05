{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.security._1password.enable {
  programs._1password-gui.enable = true;
  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        helium
      '';
      mode = "0755";
    };
  };
}
