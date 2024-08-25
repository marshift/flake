{ ... }:

{
  habitat.home = {
    cli = {
      bash.enable = true;
      gh.enable = true;
    };
    desktop = {
      hyprland.enable = true;
    };
  };

  home.stateVersion = "24.05";
}
