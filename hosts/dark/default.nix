{
  imports = [ ./disks.nix ];

  swamp = {
    hardware = {
      cpu.amd.enable = true;
      gpu = {
        enable = true;
        nvidia.enable = true;
      };
      bluetooth.enable = true;
      rgb = {
        color = "FF0000";
        resizableARGBZones = [
          {
            device = "MSI MPG B550 GAMING PLUS (MS-7C56)";
            id = "1";
            size = "10";
          }
          {
            device = "MSI MPG B550 GAMING PLUS (MS-7C56)";
            id = "2";
            size = "6";
          }
        ];
      };
      monitors = [
        {
          criteria = "DP-2";
          mode = "3440x1440@144.000000Hz";
          position = "0,0";
          scale = 1.0;
        }
        {
          criteria = "DP-1";
          mode = "1920x1080@60.000000Hz";
          position = "3440,0";
          scale = 1.0;
        }
      ];
    };

    users.users = [ "marsh" ];
    secrets.sshKeyPaths = [ "/home/marsh/.ssh/sops_ed25519" ];

    desktop.enable = true;
    social.enable = true;
    media.enable = true;
    development.enable = true;
    gaming = {
      enable = true;
      vr.enable = true;
    };
    security.bitwarden.enable = true;
  };
}
