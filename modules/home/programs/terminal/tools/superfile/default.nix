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
  cfg = config.programs.terminal.tools.superfile;
in
{
  options.programs.terminal.tools.superfile = with types; {
    enable = mkBoolOpt false "enable superfile";
  };

  config = mkIf cfg.enable {
    programs.superfile = {
      enable = true;
    };

    programs.zsh = {
      shellAliases = {
        sf = "${pkgs.superfile}/bin/superfile";
      };
    };
  };
}
