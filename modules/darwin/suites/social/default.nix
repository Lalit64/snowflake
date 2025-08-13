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
  cfg = config.suites.social;
in
{
  options.suites.social = with types; {
    enable = mkBoolOpt false "enable social suite";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [
      "whatsapp"
      "zoom"
      "protonvpn"
      "vesktop"
    ];
  };
}
