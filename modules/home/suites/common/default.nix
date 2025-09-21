{
  options,
  config,
  lib,
  namespace,
  pkgs,
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
          ghostty.enable = true;
        };

        shell = {
          zsh.enable = true;
        };

        tools = {
          direnv.enable = true;
          fastfetch.enable = true;
          git.enable = true;
          lf.enable = true;
          nh.enable = true;
          starship.enable = true;
        };
      };
    };

    services = {
      sketchy.enable = true;
      karabiner.enable = true;
    };
  };
}
