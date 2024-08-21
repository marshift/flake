{ inputs, system, ... }:
{
  systemd.user.services.xwayland-satellite = {
    Unit = {
      Description = "xwayland-satellite";
      PartOf = [ "graphical-session.target" ];
      Requires = [ "niri.service" ];
      After = [ "niri.service" ];
    };
    Service = {
      ExecStart = "${inputs.niri.packages.${system}.xwayland-satellite}/bin/xwayland-satellite";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "niri.service" ];
    };
  };
}
