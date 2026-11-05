{
  self,
  config,
  ...
}:
{
  options.swamp.development.vscode.enable =
    self.lib.options.mkEnableOptionWithDefault "Visual Studio Code"
      (config.swamp.development.enable && config.swamp.desktop.enable);
}
