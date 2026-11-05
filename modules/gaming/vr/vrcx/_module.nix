{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib.options) mkOption mkEnableOption;

  cfg = config.programs.vrcx;
  escapeSQL = statement: "'" + (lib.replaceString "'" "''" statement) + "'";

  sqlStatements = lib.attrsets.mapAttrsToList (
    key: value:
    "INSERT INTO configs(key, value) VALUES(${escapeSQL key}, ${escapeSQL value}) ON CONFLICT(key) DO UPDATE SET value=excluded.value"
  ) cfg.config;
in
{
  options.programs.vrcx = {
    enable = mkEnableOption "declarative configuration of VRCX settings";

    config = mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
    };
  };

  config = lib.modules.mkIf cfg.enable {
    home.activation.vrcxSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ -f $HOME/.config/VRCX/VRCX.sqlite3 ]; then
        echo "applying VRCX settings..."
        ${pkgs.sqlite}/bin/sqlite3 $HOME/.config/VRCX/VRCX.sqlite3 ${lib.escapeShellArgs sqlStatements}
      fi
    '';
  };
}
