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
  cfg = config.theme.stylix;
in
{
  options.theme.stylix = with types; {
    enable = mkBoolOpt false "enable stylix theme";
    theme = mkOpt str "tokyo-night-moon" "base16 theme to use";
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      autoEnable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${cfg.theme}.yaml";
      targets.xresources.enable = true;

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.caskaydia-mono;
          name = "CaskaydiaMono NF";
        };
      };
    };

    home.file = {
      ".config/sketchybar/theme.lua" = {
        text = ''
          return {
            crust = 0xff${config.lib.stylix.colors.base00},
            mantle = 0xff${config.lib.stylix.colors.base01},
            base = 0xff${config.lib.stylix.colors.base02},
            text = 0xff${config.lib.stylix.colors.base05},
            muted = 0xff${config.lib.stylix.colors.base04},
            red = 0xff${config.lib.stylix.colors.base08},
            orange = 0xff${config.lib.stylix.colors.base09},
            yellow = 0xff${config.lib.stylix.colors.base0A},
            green = 0xff${config.lib.stylix.colors.base0B},
            cyan = 0xff${config.lib.stylix.colors.base0C},
            blue = 0xff${config.lib.stylix.colors.base0D},
            purple = 0xff${config.lib.stylix.colors.base0E},
          } 
        '';
      };
    };
  };
}
