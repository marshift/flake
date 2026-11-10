{
  nix.settings = {
    sandbox = true;
    allowed-users = [ "@wheel" ];
    trusted-users = [ "@wheel" ];
  };

  # https://github.com/NixOS/nix/issues/9574
  systemd.tmpfiles.rules = [
    "R /root/.nix-defexpr/channels"
    "R /nix/var/nix/profiles/per-user/root/channels"
    "R /nix/var/nix/profiles/per-user/root/channels-*-link"
  ];
}
