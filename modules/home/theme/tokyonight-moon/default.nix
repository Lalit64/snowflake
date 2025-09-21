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
  cfg = config.theme.tokyonight-moon;
in
{
  options.theme.tokyonight-moon = with types; {
    enable = mkBoolOpt false "enable tokyonight-moon theme";
  };

  config = mkIf cfg.enable {
    programs.ghostty.settings = mkIf config.programs.terminal.emulators.ghostty.enable {
      theme = "TokyoNight Moon";
    };

    programs.vscode = mkIf config.programs.graphical.editors.vscode.enable {
      profiles = {
        default = {
          extensions = with pkgs.vscode-extensions; [
            enkia.tokyo-night
          ];
          userSettings = {
            workbench.colorTheme = "Tokyo Night";
          };
        };
      };
    };

    programs.opencode = mkIf config.programs.terminal.tools.opencode.enable {
      settings = {
        theme = "tokyonight";
      };
    };

    home.file = {
      ".config/sketchybar/theme.lua" = {
        text = ''
          return {
            crust = 0xff1a1b26,
            mantle = 0xff414868,
            base = 0xff24283b,
            text = 0xffc0caf5,
            muted = 0xff9aa5ce,
            red = 0xfff7768e,
            orange = 0xffff9e64,
            yellow = 0xffe0af68,
            green = 0xff9ece6a,
            cyan = 0xff2ac3de,
            blue = 0xff7aa2f7,
            purple = 0xffbb9af7,
          } 
        '';
      };
    };
  };
}
