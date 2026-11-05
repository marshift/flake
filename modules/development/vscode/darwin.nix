{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.development.vscode.enable {
  homebrew.casks = [ "visual-studio-code" ];
}
