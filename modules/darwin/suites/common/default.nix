{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.suites.common;
in
{
  imports = [ (lib.snowfall.fs.get-file "modules/shared/suites/common/default.nix") ];

  config = mkIf cfg.enable {
    tools.homebrew = {
      enable = mkDefault true;
      mas = mkDefault true;
    };

    system = {
      nix.enable = true;
      fonts.enable = true;
      input.enable = true;
      interface.enable = true;
      networking.enable = true;
    };
  };
}
