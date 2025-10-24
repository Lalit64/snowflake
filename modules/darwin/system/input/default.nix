{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.system.input;
in
{
  options.system.input = with types; {
    enable = mkBoolOpt false "enable input";
  };

  config = mkIf cfg.enable {
    security.pam.services.sudo_local.touchIdAuth = true;

    services.karabiner.enable = true;

    system = {
      keyboard.enableKeyMapping = true;
      keyboard.remapCapsLockToEscape = true;

      defaults = {
        CustomUserPreferences = {
          "com.apple.HIToolbox" = {
            AppleCurrentKeyboardLayoutInputSourceID = "com.apple.keylayout.US";
            AppleEnabledInputSources = [
              {
                InputSourceKind = "Keyboard Layout";
                "KeyboardLayout ID" = 0;
                "KeyboardLayout Name" = "U.S.";
              }
            ];
          };
        };

        # trackpad settings
        trackpad = {

          ActuationStrength = 0; # silent clicking = 0, default = 1
          Clicking = true; # enable tap to click
          Dragging = true; # Enable tap to drag
          # firmness level, 0 = lightest, 2 = heaviest
          FirstClickThreshold = 1;
          SecondClickThreshold = 1; # firmness level for force touch
          TrackpadRightClick = true;
          TrackpadThreeFingerDrag = true; # three finger drag
        };

        NSGlobalDomain = {
          InitialKeyRepeat = 10;
          KeyRepeat = 1;
          "com.apple.trackpad.trackpadCornerClickBehavior" = 1; # enable right click on macbook
        };

        ".GlobalPreferences" = {
          "com.apple.mouse.scaling" = 1.0;
        };
      };
    };
  };
}
