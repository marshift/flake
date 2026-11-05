{
  imports = [
    ./vscode.nix
  ];

  programs = {
    git.settings.user = {
      name = "marshift";
      email = "marshift@riseup.net";
    };

    ssh.settings."sanctuary" = {
      ForwardAgent = "yes";
    };
  };
}
