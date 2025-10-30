{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.suites.social;
in
{
  options.suites.social = with types; {
    enable = mkBoolOpt false "enable social suite";
  };

  config = mkIf cfg.enable {
    programs = {
      graphical = {
        social = {
          vesktop.enable = true;
        };
      };
    };
  };
}
