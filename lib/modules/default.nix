{ lib, namespace, ... }:

{
  ## Create a toggleable, namespaced module
  mkModule = { config, path, output, extraOptions ? {} }: let
    name = lib.last path;
    realPath = [namespace] ++ path;
    mergedOptions = lib.mergeAttrs { enable = lib.mkEnableOption name; } extraOptions;
  in
  {
    options = lib.setAttrByPath realPath mergedOptions;
    config = lib.mkIf (lib.attrByPath (realPath ++ ["enable"]) false config) output;
  };
}
