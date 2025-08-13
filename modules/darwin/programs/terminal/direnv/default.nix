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
  cfg = config.programs.terminal.direnv;
in
{
  options.programs.terminal.direnv = with types; {
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
