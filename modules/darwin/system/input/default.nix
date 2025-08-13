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
    enable = mkBoolOpt false "enable input configuration";
  };

  config = mkIf cfg.enable {
    security.pam.services.sudo_local.touchIdAuth = true;

    system = {
      keyboard.enableKeyMapping = true;
      keyboard.remapCapsLockToEscape = true;

      defaults = {
        # trackpad settings
        trackpad = {
          # silent clicking = 0, default = 1
          ActuationStrength = 0;
          # enable tap to click
          Clicking = true;
          # Enable tap to drag
          # Dragging = true;
          # firmness level, 0 = lightest, 2 = heaviest
          FirstClickThreshold = 1;
          # firmness level for force touch
          SecondClickThreshold = 1;
          # don't allow positional right click
          TrackpadRightClick = true;
          # three finger drag
          TrackpadThreeFingerDrag = true;
        };

        ".GlobalPreferences" = {
          "com.apple.mouse.scaling" = 1.0;
        };
      };
    };
  };
}
