{
  lib,
  pkgs,
  osConfig,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
  inherit (lib.strings) enableFeature;
in
{
  imports = [
    ./_module.nix
  ];

  config = mkIf osConfig.swamp.desktop.helium.enable {
    programs.helium = {
      package = mkIf isDarwin null;
      enable = true;

      # TODO: Figure out how to pass command-line args on Darwin with Homebrew
      # "Cannot set `commandLineArgs` when `package` is null for helium."
      commandLineArgs = mkIf isLinux [
        "--no-first-run"
        (enableFeature true "gpu-rasterization")
        (enableFeature true "oop-rasterization")
        (enableFeature true "parallel-downloading")
        (enableFeature true "experimental-web-platform-features")

        "--ignore-gpu-blocklist"
        "--disable-gpu-driver-bug-workaround"
        (enableFeature true "zero-copy")
      ];

      extensions = [
        "icpgjfneehieebagbmdbhnlpiopdcmna" # New Tab Redirect
        "hhinaapppaileiechjoiifaancjggfjm" # Web Scrobbler
      ];
    };
  };
}
