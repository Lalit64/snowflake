{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.tools.homebrew;
in
{
  options.tools.homebrew = with types; {
    enable = mkBoolOpt false "enable homebrew";
    mas = mkBoolOpt true "enable mac app store";
  };

  config = mkIf cfg.enable {
    environment.systemPackages =
      with pkgs;
      mkIf cfg.mas [
        mas
      ];

    homebrew = {
      enable = true;

      caskArgs.no_quarantine = true;

      global = {
        brewfile = true;
        autoUpdate = true;
      };

      onActivation = {
        autoUpdate = true;
        cleanup = "uninstall";
        upgrade = true;
      };
    };
  };
}
