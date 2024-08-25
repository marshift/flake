{ config, lib, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "home" "cli" "bash" ];
  output = {
    programs.bash = {
      enable = true;

      shellAliases = {
        rebuild-flake = "nixos-rebuild switch --use-remote-sudo --flake";
      };

      sessionVariables = {
        PS1 = "\\u@\\h:\\w\\$ "; # TODO: Colour the prompt!
        NIX_SHELL_PRESERVE_PROMPT = 1;
      };

      historyFile = "$HOME/.bash_history";
      historyControl = [
        "ignorespace"
        "ignoredups"
      ];
    };
  };
}
