{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.programs.terminal.emulators.wezterm;
in
{
  options.programs.terminal.emulators.wezterm = with types; {
    enable = mkBoolOpt false "enable wezterm";
  };

  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;

      extraConfig =
        let
          font = "CaskaydiaMono NF";
        in
        ''
            local action = wezterm.action

            local M = {
              -- general
              audible_bell = "Disabled",
              check_for_updates = false,
              enable_scroll_bar = false,
              exit_behavior = "CloseOnCleanExit",
              warn_about_missing_glyphs =  false,
              term = "xterm-256color",
              clean_exit_codes = { 130 },

              -- anims
              animation_fps = 1,

              -- cursor
              cursor_blink_ease_in = 'EaseIn',
              cursor_blink_ease_out = 'EaseOut',
              cursor_blink_rate = 700,
              default_cursor_style = "BlinkingUnderline",

              -- font
              font_size = 16.0,
              font = wezterm.font_with_fallback({
                {
                  family = "${font}",
                },
                "Apple Color Emoji"
              }),
              line_height = 1.3,
              
              -- keymap
              keys = {
                { mods = "OPT", key = "LeftArrow", action = action.SendKey({ mods = "ALT", key = "b" }) },
                { mods = "OPT", key = "RightArrow", action = action.SendKey({ mods = "ALT", key = "f" }) },
                { mods = "CMD", key = "LeftArrow", action = action.SendKey({ mods = "CTRL", key = "a" }) },
                { mods = "CMD", key = "RightArrow", action = action.SendKey({ mods = "CTRL", key = "e" }) },
                { mods = "CMD", key = "Backspace", action = action.SendKey({ mods = "CTRL", key = "u" }) },
                { mods = "CMD", key = "k", action = action.Multiple { action.ClearScrollback 'ScrollbackAndViewport', action.SendKey { key = 'l', mods = 'CTRL' }, }, },
                { key = 'n', mods = 'CMD', action = action.SpawnCommandInNewWindow { cwd=wezterm.home_dir } },
                { key = 't', mods = 'CMD', action = action.SpawnCommandInNewTab { cwd=wezterm.home_dir } },
                { key = 'd', mods = 'CMD', action = action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
                { key = 'd', mods = 'CMD|SHIFT', action = action.SplitVertical { domain = 'CurrentPaneDomain' } },
              },

              -- tab bar
              enable_tab_bar = true,
              hide_tab_bar_if_only_one_tab = true,
              tab_bar_at_bottom = true,
              use_fancy_tab_bar = false,
              -- try and let the tabs stretch instead of squish
              tab_max_width = 10000,

              -- perf
              scrollback_lines = 10000,

              -- term window settings
              adjust_window_size_when_changing_font_size = false,
              window_background_opacity = 0.85,
              macos_window_background_blur = 64,              -- enables blur, set strength (higher = more blur)
              window_close_confirmation = "NeverPrompt",
              window_decorations = "RESIZE | MACOS_FORCE_SQUARE_CORNERS",
              window_padding = { left = 24, right = 24, top = 24, bottom = 24, },
            }

            function tab_title(tab_info)
              local title = tab_info.tab_title
              -- if the tab title is explicitly set, take that
              if title and #title > 0 then
                return title
              end
              -- otherwise, use the title from the active pane
              -- in that tab
              return tab_info.active_pane.title
            end

            wezterm.on(
            'format-tab-title',
            function(tab, tabs, panes, config, hover, max_width)
              local title = tab_title(tab)

              return ' ' .. title .. ' '
            end
          )
        '';
    };
  };
}
