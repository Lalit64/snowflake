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
  cfg = config.system.networking.tailscale;
in
{
  options.system.networking.tailscale = with types; {
    enable = mkBoolOpt false "enable tailscale";
    authFile = mkOpt str "" "tailscale authkey file";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      tailscale
    ];

    system.defaults.CustomSystemPreferences = {
      "io.tailscale.ipn.macos"."FileSharingConfiguration" = "show";
    };

    services.tailscale = {
      enable = true;
    };

    system.activationScripts = {
      serviceConfig = {
        Label = "com.tailscale.tailscale";
        UserName = "${config.user.name}";
        ProgramArguments = [
          "${pkgs.tailscale}/bin/tailscale login"
          "--authKey"
          "tskey-auth-k7Ztk9irJu11CNTRL-9SFVHBcPtTPB7iLjc6SXUPhzTmpzMGWM"
        ];
        RunAtLoad = true;
        KeepAlive = {
          SuccessfulExit = false;
        };
      };
    };
  };
}
