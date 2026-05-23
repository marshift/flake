{
  lib,
  username,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username}.home = {
      inherit username;
      homeDirectory = "/home/${username}";
    };
  };
}
