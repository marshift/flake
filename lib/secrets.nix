{
  inputs,
  lib,
}:
let
  mkSecret =
    { file, scope, ... }@args:
    let
      args' = lib.attrsets.removeAttrs args [
        "file"
        "scope"
      ];
    in
    {
      sopsFile = "${inputs.self}/secrets/${scope}/${file}";
    }
    // args';
in
{
  inherit mkSecret;
}
