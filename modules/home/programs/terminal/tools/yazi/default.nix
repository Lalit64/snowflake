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
  cfg = config.programs.terminal.tools.yazi;
in
{
  options.programs.terminal.tools.yazi = with types; {
    enable = mkBoolOpt false "enable yazi";
  };

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        mgr = {
          show_hidden = true;
          sort_dir_first = true;
        };
      };
    };
  };
}
