{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.modules.mkIf osConfig.swamp.development.rust.enable {
  home.packages = with pkgs; [
    cargo
    rustc
    rust-analyzer
  ];
}
