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
      vscodium
      desktoppr
    ];

    homebrew.casks = [
      "background-music"
      "zen@twilight"
      "wezterm@nightly"
      "karabiner-elements"
      "rustdesk"
      "helium-browser"
    ];

    wms.aerospace = {
      enable = true;
    };

    system.activationScripts = {
      wallpaper.text = ''
        ${pkgs.desktoppr}/bin/desktoppr "${pkgs.wallpapers}/share/wallpapers/gruvbox-skyline.png"
      '';
    };

    services.sketchy.enable = true;
    services.borders.enable = true;
  };
}
