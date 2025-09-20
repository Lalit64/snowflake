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
    enable = mkBoolOpt false "enable interface configuration";
  };

  config = mkIf cfg.enable {
    system.defaults = {
      CustomSystemPreferences = {
        finder = {
          DisableAllAnimations = true;
          FXEnableExtensionChangeWarning = false;
          QuitMenuItem = true;
          ShowExternalHardDrivesOnDesktop = false;
          ShowHardDrivesOnDesktop = false;
          ShowMountedServersOnDesktop = false;
          ShowPathbar = true;
          ShowRemovableMediaOnDesktop = false;
          _FXSortFoldersFirst = true;
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
          "${pkgs.${namespace}.helium}/Applications/Helium.app/"
          "/Applications/Ghostty.app/"
          "/System/Applications/Music.app/"
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

      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleShowAllExtensions = true;
        AppleShowScrollBars = "Automatic";
        NSAutomaticWindowAnimationsEnabled = false;
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
