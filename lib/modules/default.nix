{ lib, namespace, ... }:

rec {
  ## Create a boolean option with a default value
  mkBooleanOption = default: lib.mkOption { inherit default; type = lib.types.bool; };

  ## Create a toggleable, namespaced module
  mkModule = { config, path, output, default ? false, extraOptions ? {} }: let
    realPath = [namespace] ++ path;
    mergedOptions = lib.mergeAttrs { enable = mkBooleanOption default; } extraOptions;
  in
  {
    options = lib.setAttrByPath realPath mergedOptions;
    config = lib.mkIf (lib.attrByPath (realPath ++ ["enable"]) false config) output;
  };
}
