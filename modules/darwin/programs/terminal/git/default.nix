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
  cfg = config.programs.terminal.git;
in
{
  options.programs.terminal.git = with types; {
    enable = mkBoolOpt false "enable git";
  };

  config = mkIf cfg.enable {
    home.programs.git = {
      enable = true;
      userName = config.user.fullname;
      userEmail = config.user.email;
    };

    home.programs.lazygit = {
      enable = true;
    };
  };
}
