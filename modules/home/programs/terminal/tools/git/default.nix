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
  cfg = config.programs.terminal.tools.git;
in
{
  options.programs.terminal.tools.git = with types; {
    enable = mkBoolOpt false "enable git";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = config.user.fullname;
          email = config.user.email;
        };
      };
    };

    programs.jujutsu = {
      enable = true;
      settings = {
        user = {
          name = config.user.fullname;
          email = config.user.email;
        };
      };
    };

    programs.lazygit = {
      enable = true;
    };

    programs.gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
      };
      extensions = with pkgs; [
        gh-dash
      ];
    };

    programs.gh-dash = {
      enable = true;
      settings = { };
    };
  };
}
