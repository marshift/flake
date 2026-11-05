{
  nix.settings = {
    sandbox = true;
    allowed-users = [ "@wheel" ];
    trusted-users = [ "@wheel" ];
  };
}
