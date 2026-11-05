{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.development.idea.enable {
  homebrew.casks = [ "intellij-idea" ];
}
