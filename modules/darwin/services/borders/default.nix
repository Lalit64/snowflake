{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.services.borders;
in
{
  options.services.borders = with types; {
    enable = mkBoolOpt false "enable jankyborders";
  };

  config = mkIf cfg.enable {
    services.jankyborders = {
      enable = true;

      style = "square";
      width = 3.0;
      hidpi = true;

      active_color = "0xff83a598";
      inactive_color = "0x00ffffff";

      whitelist = [
        "wezterm-gui"
      ];
    };
  };
}
