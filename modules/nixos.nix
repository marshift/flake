{
  self,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  assertions = [ (self.lib.modules.assertIsLinux pkgs) ];

  programs.nix-ld.enable = true;
  services.gvfs.enable = true; # Samba
}
