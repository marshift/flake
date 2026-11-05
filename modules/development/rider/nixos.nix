{
  pkgs,
  ...
}:
{
  programs.nix-ld.libraries = [ pkgs.icu ];
}
