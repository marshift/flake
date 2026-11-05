{
  lib,
  osConfig,
  ...
}:
lib.modules.mkIf osConfig.swamp.development.git.enable {
  programs = {
    git = {
      enable = true;
      settings = {
        core.autocrlf = "input";
        init.defaultBranch = "master";
      };
    };
    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
      };
    };
  };
}
