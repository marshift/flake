{
  inputs,
  lib,
  config,
  ...
}:
{
  imports = [
    inputs.stylix.darwinModules.stylix
  ];

  system.activationScripts.postActivation.text = lib.modules.mkAfter ''
    echo "setting wallpaper..."
    /usr/bin/osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"${config.stylix.image}\""
  '';
}
