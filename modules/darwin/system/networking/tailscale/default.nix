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
  cfg = config.system.networking.tailscale;
in
{
  options.system.networking.tailscale = with types; {
    enable = mkBoolOpt false "enable tailscale";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [
      "tailscale-app"
    ];

    system.defaults.CustomSystemPreferences = {
      "io.tailscale.ipn.macos"."FileSharingConfiguration" = "show";
    };
  };
}
