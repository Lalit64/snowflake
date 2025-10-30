{
  config,
  lib,
  namespace,
  pkgs,
  system,
  inputs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.programs.graphical.social.vesktop;
in
{
  options.programs.graphical.social.vesktop = with types; {
    enable = mkBoolOpt false "enable vesktop";
  };

  config = mkIf cfg.enable {
    programs.vesktop = {
      enable = true;

      settings = {
        discordBranch = "stable";

        minimizeToTray = false;
        arRPC = true;
      };

      vencord = {
        settings = {
          autoUpdate = false;
          autoUpdateNotification = false;

          useQuickCss = true;
          themeLinks = [ ];
          enableReactDevtools = true;
          transparent = true;
          disableMinSize = true;

          plugins = {
            FakeNitro = {
              enabled = true;
            };
            AlwaysAnimate = {
              enabled = true;
            };
            AlwaysExpandRoles = {
              enabled = true;
            };
            AlwaysTrust = {
              enabled = true;
            };
            BetterSessions = {
              enabled = true;
            };
            CrashHandler = {
              enabled = true;
            };
            FixImagesQuality = {
              enabled = true;
            };
            PlatformIndicators = {
              enabled = true;
            };
            ReplyTimestamp = {
              enabled = true;
            };
            ShowHiddenChannels = {
              enabled = true;
            };
            ShowHiddenThings = {
              enabled = true;
            };
            VencordToolbox = {
              enabled = true;
            };
            WebKeybinds = {
              enabled = true;
            };
            WebScreenShareFixes = {
              enabled = true;
            };
            YoutubeAdblock = {
              enabled = true;
            };
            BadgeAPI = {
              enabled = true;
            };
            NoTrack = {
              enabled = true;
              disableAnalytics = true;
            };
            Settings = {
              enabled = true;
              settingsLocation = "aboveNitro";
            };
          };
        };
      };
    };
  };
}
