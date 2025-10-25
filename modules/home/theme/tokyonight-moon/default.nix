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
  cfg = config.theme.tokyonight-moon;
in
{
  options.theme.tokyonight-moon = with types; {
    enable = mkBoolOpt false "enable tokyonight-moon theme";
  };

  config = mkIf cfg.enable {
    programs.nushell.configFile.text = ''
      source nu-themes/tokyonight-moon.nu
    '';

    programs.wezterm = mkIf config.programs.terminal.emulators.wezterm.enable {
      extraConfig = ''
        M.color_scheme = "Tokyo Night Moon"

        return M
      '';
    };

    programs.zsh = {
      initContent = ''
        export FZF_DEFAULT_OPTS='--color="bg+:#2d3f76,border:#589ed7,fg:#c8d3f5,gutter:#1e2030,header:#ff966c,hl:#65bcff,hl+:#65bcff,info:#545c7e,marker:#ff007c,pointer:#ff007c,prompt:#65bcff,query:#c8d3f5:regular,scrollbar:#589ed7,separator:#ff966c,spinner:#ff007c" '$FZF_DEFAULT_OPTS
      '';
    };

    programs.superfile = {
      settings = {
        theme = "tokyonight";
      };
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

      "Library/Application Support/nushell/nu-themes/tokyonight-moon.nu" = {
        text = ''
                    # Retrieve the theme settings
          export def main [] {
              return {
                  separator: "#828bb8"
                  leading_trailing_space_bg: { attr: "n" }
                  header: { fg: "#c3e88d" attr: "b" }
                  empty: "#82aaff"
                  bool: {|| if $in { "#86e1fc" } else { "light_gray" } }
                  int: "#828bb8"
                  filesize: {|e|
                      if $e == 0b {
                          "#828bb8"
                      } else if $e < 1mb {
                          "#86e1fc"
                      } else {{ fg: "#82aaff" }}
                  }
                  duration: "#828bb8"
                  datetime: {|| (date now) - $in |
                      if $in < 1hr {
                          { fg: "#ff757f" attr: "b" }
                      } else if $in < 6hr {
                          "#ff757f"
                      } else if $in < 1day {
                          "#ffc777"
                      } else if $in < 3day {
                          "#c3e88d"
                      } else if $in < 1wk {
                          { fg: "#c3e88d" attr: "b" }
                      } else if $in < 6wk {
                          "#86e1fc"
                      } else if $in < 52wk {
                          "#82aaff"
                      } else { "dark_gray" }
                  }
                  range: "#828bb8"
                  float: "#828bb8"
                  string: "#828bb8"
                  nothing: "#828bb8"
                  binary: "#828bb8"
                  cell-path: "#828bb8"
                  row_index: { fg: "#c3e88d" attr: "b" }
                  record: "#828bb8"
                  list: "#828bb8"
                  block: "#828bb8"
                  hints: "dark_gray"
                  search_result: { fg: "#f7768e" bg: "#828bb8" }

                  shape_and: { fg: "#c099ff" attr: "b" }
                  shape_binary: { fg: "#c099ff" attr: "b" }
                  shape_block: { fg: "#82aaff" attr: "b" }
                  shape_bool: "#86e1fc"
                  shape_custom: "#c3e88d"
                  shape_datetime: { fg: "#86e1fc" attr: "b" }
                  shape_directory: "#86e1fc"
                  shape_external: "#86e1fc"
                  shape_externalarg: { fg: "#c3e88d" attr: "b" }
                  shape_filepath: "#86e1fc"
                  shape_flag: { fg: "#82aaff" attr: "b" }
                  shape_float: { fg: "#c099ff" attr: "b" }
                  shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: "b" }
                  shape_globpattern: { fg: "#86e1fc" attr: "b" }
                  shape_int: { fg: "#c099ff" attr: "b" }
                  shape_internalcall: { fg: "#86e1fc" attr: "b" }
                  shape_list: { fg: "#86e1fc" attr: "b" }
                  shape_literal: "#82aaff"
                  shape_match_pattern: "#c3e88d"
                  shape_matching_brackets: { attr: "u" }
                  shape_nothing: "#86e1fc"
                  shape_operator: "#ffc777"
                  shape_or: { fg: "#c099ff" attr: "b" }
                  shape_pipe: { fg: "#c099ff" attr: "b" }
                  shape_range: { fg: "#ffc777" attr: "b" }
                  shape_record: { fg: "#86e1fc" attr: "b" }
                  shape_redirection: { fg: "#c099ff" attr: "b" }
                  shape_signature: { fg: "#c3e88d" attr: "b" }
                  shape_string: "#c3e88d"
                  shape_string_interpolation: { fg: "#86e1fc" attr: "b" }
                  shape_table: { fg: "#82aaff" attr: "b" }
                  shape_variable: "#c099ff"

                  background: "#222436"
                  foreground: "#c8d3f5"
                  cursor: "#c8d3f5"
              }
          }

          # Update the Nushell configuration
          export def --env "set color_config" [] {
              $env.config.color_config = (main)
          }

          # Update terminal colors
          export def "update terminal" [] {
              let theme = (main)

              # Set terminal colors
              let osc_screen_foreground_color = '10;'
              let osc_screen_background_color = '11;'
              let osc_cursor_color = '12;'
                  
              $"
              (ansi -o $osc_screen_foreground_color)($theme.foreground)(char bel)
              (ansi -o $osc_screen_background_color)($theme.background)(char bel)
              (ansi -o $osc_cursor_color)($theme.cursor)(char bel)
              "
          }

          export module activate {
              export-env {
                  set color_config
                  update terminal
              }
          }

          # Activate the theme when sourced
          use activate
        '';
      };
    };
  };
}
