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
  cfg = config.tools.homebrew;
in
{
  options.suites.common = with types; {
    enable = mkBoolOpt false "enable common suite";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      automake
      jq
      nixd
      nixfmt-rfc-style
      wget
    ];
  };
}
