{
  config,
  lib,
  namespace,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.system.fonts;
in
{
  options.system.fonts = with types; {
    enable = mkBoolOpt false "enable fonts";
  };

  config = mkIf cfg.enable {
    homebrew.casks = mkIf config.tools.homebrew.enable [
      "sf-symbols"
      "font-sf-mono"
      "font-sf-pro"
    ];

    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.caskaydia-mono
      sketchybar-app-font
    ];

    system = {
      defaults = {
        NSGlobalDomain = {
          AppleFontSmoothing = 1;
        };
      };
    };
  };
}
