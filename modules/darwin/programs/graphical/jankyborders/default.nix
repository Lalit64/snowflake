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
  cfg = config.programs.graphical.jankyborders;
in
{
  options.programs.graphical.jankyborders = with types; {
    enable = mkBoolOpt false "enable jankyborders";
  };

  config = mkIf cfg.enable {
    services.jankyborders = {
      enable = true;

      style = "round";
      width = 3.0;
      hidpi = true;

      active_color = "0xff7aa2f7";
      inactive_color = "0x00ffffff";

      whitelist = [
        "ghostty"
      ];
    };
  };
}
