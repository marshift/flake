{
  config,
  ...
}:
{
  programs.firejail.enable = config.swamp.security.firejail.enable;
}
