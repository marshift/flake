{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.development.rider.enable {
  homebrew.casks = [
    "rider"
    "dotnet-sdk"
  ];
}
