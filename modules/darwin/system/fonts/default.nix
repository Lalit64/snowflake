{
  options,
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
    enable = mkBoolOpt false "enable fonts configuration";
  };

  config = mkIf cfg.enable {
    homebrew.casks = mkIf config.tools.homebrew.enable [
      "sf-symbols"
      "font-sf-mono"
      "font-sf-pro"
      "font-sketchybar-app-font"
    ];

    fonts.packages = with pkgs; [
      inputs.lalit64-nur.packages."${system}".monolisa-nf # MonoLisa Nerd Font Mono
      inputs.lalit64-nur.packages."${system}".operator-nf # Operator Nerd Font Mono

      nerd-fonts.jetbrains-mono
      nerd-fonts.caskaydia-cove
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
