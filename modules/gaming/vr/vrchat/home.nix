{
  inputs,
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:
let
  inherit (lib.strings) toJSON;
in
{
  imports = [ inputs.steam-config-nix.homeModules.default ];

  config = lib.modules.mkIf osConfig.swamp.gaming.vr.vrchat.enable {
    xdg.dataFile."xrizer/vrchat/oculustouch.json".source = ./bindings.json;

    programs.steam.config.apps."438100" = {
      name = "VRChat";

      env.XRIZER_CUSTOM_BINDINGS_DIR = "${config.home.homeDirectory}/.local/share/xrizer/vrchat";

      compatTool = inputs.nixpkgs-xr.packages.${pkgs.stdenv.hostPlatform.system}.proton-rtsp-bin;
      betaBranch = "open-beta";

      files.prefix.patch."user.reg" = {
        format = "unityPrefs";
        content."Software/VRChat/VRChat" = {
          # Classic loading screen
          StartupLoadingScreenID = toJSON {
            id = "aabF_a8130296-6789-4e03-9ca3-c85486fca950";
            url = "https://assets.vrchat.com/adminfiles/adfl_7fcf70ea-38c3-4892-9ce5-f88920efe188ie_classic_v2_standalonewindows64";
            unityVersion = "2022.3.22f1";
            platform = "standalonewindows";
            assetVersion = 1;
          };
        };
      };
    };
  };
}
