{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.modules.mkIf osConfig.swamp.development.just.enable {
  home.packages = with pkgs; [
    just
    just-lsp
  ];
}
