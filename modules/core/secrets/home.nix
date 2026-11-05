{
  osConfig,
  ...
}:
{
  sops = { inherit (osConfig.sops) age; };
}
