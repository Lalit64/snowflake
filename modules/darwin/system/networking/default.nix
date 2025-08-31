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
  cfg = config.system.networking;
in
{
  options.system.networking = with types; {
    enable = mkBoolOpt false "enable networking configuration";
  };

  config = mkIf cfg.enable {
    networking = {
      knownNetworkServices = [
        # Keep macOS network services consistent
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
    homebrew.casks = [
      "motrix"
    ];
  };
}
