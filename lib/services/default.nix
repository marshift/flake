{ lib, ... }:

{
  mkGraphicalService = { description, targetService, execStart }: {
    Unit = {
      Description = description;
      PartOf = [ "graphical-session.target" ];
      Requires = [ targetService ];
      After = [ targetService ];
    };
    Service = {
      ExecStart = execStart;
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ targetService ];
    };
  };
}
