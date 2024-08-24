{ lib, ... }:

{
  ## Create a toggleable module
  mkModule = { config, path, output }: let
    name = lib.last path;
    fullPath = path ++ ["enable"];
  in
  {
    options = lib.setAttrByPath fullPath (lib.mkEnableOption name);
    config = lib.mkIf (lib.attrByPath fullPath false config) output;
  };
}
