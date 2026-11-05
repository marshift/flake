{
  lib,
  osConfig,
  config,
  ...
}:
let
  accentColorHex = "%ZFF0A88";
in
lib.modules.mkIf osConfig.swamp.social.irssi.enable {
  programs.irssi = {
    enable = true;

    extraConfig = ''
      settings = {
        core = {
          real_name = "${config.home.username}";
          user_name = "${config.home.username}";
          nick = "${config.home.username}";
        };
      };
    '';

    aliases = {
      c = "connect";
      q = "quit";
      j = "join";
    };
  };

  home.file.".irssi/default.theme".text = ''
    default_color = "-1";
    info_eol = "false";

    abstracts = {
       line_start = "${accentColorHex}-%n ";
       sb_background = "%1%W";

       sb = " %n[$*]%n";
    };
  '';
}
