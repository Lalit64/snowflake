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
  cfg = config.programs.terminal.tools.lazydocker;
in
{
  options.programs.terminal.tools.lazydocker = with types; {
    enable = mkBoolOpt false "enable lazydocker";
  };

  config = mkIf cfg.enable {
    programs.lazydocker = {
      enable = true;
    };
  };
}
