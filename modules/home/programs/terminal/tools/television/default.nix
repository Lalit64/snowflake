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
  cfg = config.programs.terminal.tools.television;
in
{
  options.programs.terminal.tools.television = with types; {
    enable = mkBoolOpt false "enable television";
  };

  config = mkIf cfg.enable {
    programs.television = {
      enable = true;
      settings = {
        ui = {
          use_nerd_font_icons = true;
        };
      };
    };

    programs.nix-search-tv = {
      enable = true;
      enableTelevisionIntegration = true;

      settings = {
        indexes = [
          "nixpkgs"
          "home-manager"
        ]
        ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
          "nixos"
        ]
        ++ lib.optionals pkgs.stdenv.hostPlatform.isDarwin [
          "darwin"
        ];
      };
    };
  };
}
