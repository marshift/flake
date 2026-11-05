{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.modules.mkIf osConfig.swamp.development.javascript.enable {
  home.packages = with pkgs; [
    deno
    dprint
    nodejs
    pnpm
  ];
}
