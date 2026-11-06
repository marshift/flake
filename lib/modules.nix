{
  inputs,
  lib,
}:
let
  listModulesRecursive =
    baseName:
    lib.lists.filter (path: lib.filesystem.baseNameOf path == baseName) (
      lib.filesystem.listFilesRecursive "${inputs.self}/modules"
    );

  assertIsLinux = pkgs: {
    assertion = pkgs.stdenv.hostPlatform.isLinux;
    message = "This module should only be imported in NixOS configurations.";
  };

  assertIsDarwin = pkgs: {
    assertion = pkgs.stdenv.hostPlatform.isDarwin;
    message = "This module should only be imported on macOS.";
  };
in
{
  inherit
    listModulesRecursive
    assertIsLinux
    assertIsDarwin
    ;
}
