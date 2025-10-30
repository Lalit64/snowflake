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
  cfg = config.system.interface;
in
{
  options.system.interface = with types; {
    enable = mkBoolOpt false "enable interface";
  };

  config = mkIf cfg.enable {
    ${namespace}.home.file = {
      "Pictures/screenshots/.keep".text = "";
    };

    system.defaults = {
      CustomSystemPreferences = {
        "com.apple.desktopservices" = {
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
      };

      dock = {
        # Automatically hide and show the Dock
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.45;

        # Style options
        orientation = "left";
        show-recents = false;

        persistent-apps = [
          "/Applications/Helium.app/"
          "/Applications/WezTerm.app/"
          "/System/Applications/Music.app/"
          "${pkgs.zed-editor}/Applications/Zed.app"
        ];
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        CreateDesktop = true;
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
        # NOTE: Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
        FXPreferredViewStyle = "Nlsv";
        QuitMenuItem = true;
        ShowStatusBar = false;
        _FXShowPosixPathInTitle = true;
      };

      loginwindow = {
        # disable guest account
        GuestEnabled = false;
      };

      screencapture = {
        disable-shadow = true;
        location = "/Users/${config.user.name}/Pictures/screenshots/";
        type = "png";
      };

      controlcenter = {
        BatteryShowPercentage = true;
      };

      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleIconAppearanceTheme = "ClearAutomatic";
        AppleShowAllExtensions = true;
        AppleShowScrollBars = "Automatic";
        NSAutomaticWindowAnimationsEnabled = true;
        # _HIHideMenuBar = hmCfg.programs.sketchybar.enable;
        _HIHideMenuBar = true;
      };

      CustomUserPreferences = {
        "com.apple.SoftwareUpdate" = {
          AutomaticCheckEnabled = true;
          AutomaticDownload = 1;
          CriticalUpdateInstall = 1;
          ScheduleFrequency = 1;
        };
      };
    };
  };
}
