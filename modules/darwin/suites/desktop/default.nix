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
  cfg = config.suites.desktop;
in
{
  options.suites.desktop = with types; {
    enable = mkBoolOpt false "enable desktop suite";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      raycast
      switchaudio-osx
      hellwal
      ice-bar
      pkgs.${namespace}.helium
    ];

    homebrew.casks = [
      "background-music"
      "zen@twilight"
      "ghostty"
      "karabiner-elements"
    ];

    wms.aerospace = {
      enable = true;
    };

    system.activationScripts = {
      wallpaper.text = ''
        echo >&2 "Setting the wallpaper..."
        osascript -e 'tell application "Finder" to set desktop picture to POSIX file "${pkgs.${namespace}.wallpapers}/share/wallpapers/cloudy-quasar-tokyo-night.png"'
      '';
    };

    services.sketchybar.enable = true;
  };
}
