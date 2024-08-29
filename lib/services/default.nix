{ lib, ... }:

{
  # TODO: This is kinda awful and debatably unnecessary
  mkGraphicalService = { description, targetService, execStart, execReload ? null, killMode ? null }: {
    Unit = {
      Description = description;
      PartOf = [ "graphical-session.target" ];
      Requires = [ targetService ];
      After = [ targetService ];
    };
    Service = lib.mergeAttrsList [
      {
        ExecStart = execStart;
        Restart = "on-failure";
      }
      (lib.optionalAttrs (execReload != null) {
        ExecReload = execReload;
      })
      (lib.optionalAttrs (killMode != null) {
        KillMode = killMode;
      })
    ];
    Install = {
      WantedBy = [ targetService ];
    };
  };
}
