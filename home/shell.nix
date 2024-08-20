{ config, ... }:

{
  home.shellAliases = {
    rebuild-flake = "nixos-rebuild switch --use-remote-sudo --flake";
  };

  home.sessionVariables = {
    NIX_SHELL_PRESERVE_PROMPT=1;
    PS1="\\u@\\h:\\w\\$ "; # TODO: Colour the prompt!
  };

  programs.bash = {
    enable = true;
    historyFile = "$HOME/.bash_history";
    historyControl = [ "ignorespace" "ignoredups" ];
  };
}
