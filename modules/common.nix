{
  self,
  inputs,
  lib,
  config,
  ...
}:
{
  home-manager = {
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit self inputs; };

    users = lib.attrsets.genAttrs config.swamp.users.users (name: {
      imports = [ "${self}/homes/${name}" ];
    });

    sharedModules = self.lib.modules.listModulesRecursive "home.nix";
  };
}
