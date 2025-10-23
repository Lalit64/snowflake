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
  cfg = config.programs.terminal.tools.fastfetch;
in
{
  options.programs.terminal.tools.fastfetch = with types; {
    enable = mkBoolOpt false "enable fastfetch";
  };

  config = mkIf cfg.enable {
    programs.fastfetch = {
      enable = true;
      settings = {
        logo = {
          source = "${pkgs.${namespace}.wallpapers}/share/wallpapers/nix-darwin.png";
          type = "kitty-direct";
          width = 32;
          height = 10;
        };
        modules = [
          "os"
          "host"
          "uptime"
          "packages"
          "shell"
          "terminal"
          "terminalfont"
          "cpu"
          "gpu"
          "colors"
        ];
      };
    };
  };
}
