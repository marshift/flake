{ ... }:

{
  habitat.home = {
    cli = {
      bash.enable = true;
      gh.enable = true;
    };
    desktop = {
      steam.enable = true;
      vscode.enable = true;
      vesktop.enable = true;
      firefox.enable = true;
      fuzzel.enable = true;
      foot.enable = true;
      niri = {
        enable = true;
        keyboardLayout = "gb";
        outputs = {
          "DP-1" = {
            mode = {
              width = 3440;
              height = 1440;
              refresh = 144.0;
            };
            variable-refresh-rate = true;
          };
          "DP-2" = {
            mode = {
              width = 1920;
              height = 1080;
              refresh = 60.0;
            };
          };
        };
      };
    };
  };

  home.stateVersion = "24.05";
}
