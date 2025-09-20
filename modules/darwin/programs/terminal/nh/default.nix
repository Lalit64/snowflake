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
  cfg = config.programs.terminal.nh;
in
{
  options.programs.terminal.nh = with types; {
    enable = mkBoolOpt false "enable nh";
  };

  config = mkIf cfg.enable {
    home.programs.nh = {
      enable = true;
      package = pkgs.nh;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/Users/${config.user.name}/.config/snowflake";
    };
  };
}
