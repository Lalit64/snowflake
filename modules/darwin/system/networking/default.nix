{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.system.networking;
in
{
  options.system.networking = with types; {
    enable = mkBoolOpt false "enable networking";
  };

  config = mkIf cfg.enable {
    system.networking.tailscale = {
      enable = true;
      authFile = config.age.secrets.tailscale-authkey.path;
    };

    networking = {
      knownNetworkServices = [
        "Wi-Fi"
        "Thunderbolt Ethernet"
        "Bluetooth PAN"
      ];
      dns = [
        "1.1.1.1"
        "1.0.0.1"
        "2606:4700:4700::1111"
        "2606:4700:4700::1001"
      ];
    };
  };
}
