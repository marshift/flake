# https://github.com/different-name/nixxy/blob/852576f3cd65f351178460375c46d050de11fd0b/diffy/shared/games/avatar-tools.nix#L42
{
  lib,
  pkgs,
  osConfig,
  config,
  ...
}:
let
  # Use only the static fonts in the FHS env
  unityFontconfig = pkgs.writeText "unity-fontconfig.conf" ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
      <dir>/usr/share/fonts</dir>
      <cachedir prefix="xdg">fontconfig-unity</cachedir>
      <alias binding="strong"><family>sans-serif</family><prefer><family>DejaVu Sans</family><family>Liberation Sans</family></prefer></alias>
      <alias binding="strong"><family>serif</family><prefer><family>DejaVu Serif</family><family>Liberation Serif</family></prefer></alias>
      <alias binding="strong"><family>monospace</family><prefer><family>DejaVu Sans Mono</family><family>Liberation Mono</family></prefer></alias>
      <alias binding="strong"><family>Arial</family><prefer><family>Liberation Sans</family></prefer></alias>
      <alias binding="strong"><family>Helvetica</family><prefer><family>Liberation Sans</family></prefer></alias>
    </fontconfig>
  '';

  # Add this to ALCOM's Unity list!
  unity-editor = pkgs.writeShellScriptBin "unity-editor" ''
    export FONTCONFIG_FILE=${unityFontconfig}
    exec ${pkgs.unityhub.fhsEnv}/bin/unityhub-fhs-env \
      "${config.home.homeDirectory}/Unity/Hub/Editor/2022.3.22f1/Editor/Unity" \
      -force-vulkan "$@"
  '';
in
lib.modules.mkIf (osConfig.swamp.development.unity.enable) {
  home.packages = with pkgs; [
    unity-editor
    unityhub
    alcom
  ];
}
