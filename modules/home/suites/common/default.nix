{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.suites.common;
in
{
  options.suites.common = with types; {
    enable = mkBoolOpt false "enable common suite";
  };

  config = mkIf cfg.enable {
    home = {
      file = {
        ".hushlogin".text = "";
      };
    };

    programs = {
      terminal = {
        emulators = {
          wezterm.enable = true;
        };

        shell = {
          zsh.enable = true;
        };

        tools = {
          direnv.enable = true;
          fastfetch.enable = true;
          git.enable = true;
          jj.enable = true;
          lf.enable = true;
          nh.enable = true;
          starship.enable = true;
        };
      };
    };
  };
}
