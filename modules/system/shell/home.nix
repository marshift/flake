{
  programs = {
    zsh.enable = true;
    nix-your-shell = {
      enable = true;
      enableZshIntegration = true;
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
