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
  cfg = config.programs.graphical.ghostty;
in
{
  options.programs.graphical.ghostty = with types; {
    enable = mkBoolOpt false "enable ghostty";
  };

  config = mkIf cfg.enable {
    programs.terminal.starship.enable = true;

    homebrew.casks = [
      "ghostty"
    ];

    home.programs.ghostty = {
      enable = true;
      package = pkgs.emptyDirectory;
      enableZshIntegration = true;

      settings = {
        shell-integration = "zsh";
        shell-integration-features = "no-cursor";
        background-opacity = 0.85;
        background-blur = 255;
        font-size = 17;
        font-family = "JetBrainsMono Nerd Font Mono";
        font-thicken = true;
        cursor-style = "block";
        mouse-hide-while-typing = true;
        window-colorspace = "display-p3";
        adjust-cell-height = "30%";
        macos-titlebar-style = "hidden";
        macos-option-as-alt = "left";
        window-inherit-working-directory = false;
        window-padding-balance = true;
        window-padding-x = 15;
        window-padding-y = 15;
        # Quick Terminal
        keybind = "global:cmd+grave_accent=toggle_quick_terminal";
        quick-terminal-position = "right";
      };
    };
  };
}
