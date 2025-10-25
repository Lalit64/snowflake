{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.programs.terminal.tools.jj;
in
{
  options.programs.terminal.tools.jj = with types; {
    enable = mkBoolOpt false "enable jj";
  };

  config = mkIf cfg.enable {
    programs.jujutsu = {
      enable = true;
      settings = {
        user = {
          name = config.user.fullname;
          email = config.user.email;
        };
        fetch = {
          prune = true;
        };
        init = {
          default_branch = "main";
        };
        lfs = enabled;
        push = {
          # autoSetupRemote = true;
          default = "current";
        };
        rebase = {
          auto_stash = true;
        };
      };
    };
  };
}
