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
  cfg = config.theme.catppuccin-mocha;
in
{
  options.theme.catppuccin-mocha = with types; {
    enable = mkBoolOpt false "enable catppuccin-mocha theme";
  };

  config = mkIf cfg.enable {
    programs.wezterm = mkIf config.programs.terminal.emulators.wezterm.enable {
      extraConfig = ''
        M.color_scheme = "catppuccin-mocha"

        return M
      '';
    };

    programs.vscode = mkIf config.programs.graphical.editors.vscode.enable {
      profiles = {
        default = {
          extensions = with pkgs.vscode-extensions; [
            catppuccin.catppuccin-vsc
          ];
          userSettings = {
            workbench.colorTheme = "Catppuccin Mocha";
          };
        };
      };
    };

    programs.opencode = mkIf config.programs.terminal.tools.opencode.enable {
      settings = {
        theme = "catppuccin";
      };
    };

    home.file = {
      ".config/sketchybar/theme.lua" = {
        text = ''
          return {
            crust = 0xff1e1e2e,
            mantle = 0xff181825,
            base = 0xff1e1e2e,
            text = 0xffcdd6f4,
            muted = 0xff585b70,
            red = 0xfff38ba8,
            orange = 0xfffab387,
            yellow = 0xfff9e2af,
            green = 0xffa6e3a1,
            cyan = 0xff89dceb,
            blue = 0xff89b4fa,
            purple = 0xffcba6f7,
          } 
        '';
      };
    };
  };
}
