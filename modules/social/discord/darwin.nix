{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.social.discord.enable {
  homebrew.casks = [ "discord@canary" ];
}
