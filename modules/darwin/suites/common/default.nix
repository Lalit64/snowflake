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
    programs.terminal.zsh = {
      enable = true;
    };

    tools.homebrew = {
      enable = mkDefault true;
      masEnable = mkDefault true;
    };

    system.security.sops = {
      enable = true;
      defaultSopsFile = lib.snowfall.fs.get-file "secrets/core/default.yaml";
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
