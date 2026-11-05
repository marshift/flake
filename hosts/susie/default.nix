{
  imports = [ ./disks.nix ];

  swamp = {
    hardware = {
      asahi = {
        enable = true;
        machineId = "MacBookAir10,1";
      };
      gpu.enable = true;
      bluetooth.enable = true;
      monitors = [
        {
          criteria = "eDP-1";
          mode = "2560x1600@60.000000Hz";
          position = "0,0";
          scale = 1.75;
        }
      ];
    };

    users.users = [ "marsh" ];
    secrets.sshKeyPaths = [ "/home/marsh/.ssh/sops_ed25519" ];

    desktop.enable = true;
    social = {
      enable = true;
      discord.enable = false; # TODO: Discord don't do ARM builds at all... Dorion or Legcord?
    };
    media.enable = true;
    development.enable = true;
    security.bitwarden.enable = true;
  };
}
