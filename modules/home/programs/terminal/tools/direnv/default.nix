{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.programs.terminal.tools.direnv;
in
{
  options.programs.terminal.tools.direnv = with types; {
    enable = mkBoolOpt false "enable direnv";
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
      silent = true;
    };
  };
}
