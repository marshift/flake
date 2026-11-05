{
  inputs,
  lib,
  config,
  ...
}:
{
  imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

  nix-homebrew = {
    enable = true;
    user = config.swamp.users.primaryUser;

    mutableTaps = false;
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };
  };

  homebrew = {
    enable = true;

    global.autoUpdate = false;
    taps = lib.attrsets.attrNames config.nix-homebrew.taps;

    onActivation = {
      upgrade = true;
      cleanup = "zap";
    };
  };

  environment.variables = {
    HOMEBREW_NO_ANALYTICS = "1";
    HOMEBREW_NO_EMOJI = "1";
  };
}
