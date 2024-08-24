{ lib, ... }:

{
  ## Create a toggleable module
  mkModule = { config, path, output, extraOptions ? {} }: let
    name = lib.last path;
    statePath = path ++ ["enable"];
    mergedOptions = lib.mergeAttrs { enable = lib.mkEnableOption name; } extraOptions;
  in
  {
    options = lib.setAttrByPath path mergedOptions;
    config = lib.mkIf (lib.attrByPath statePath false config) output;
  };
}
