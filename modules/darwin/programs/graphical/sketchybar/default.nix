{
  options,
  inputs,
  config,
  lib,
  namespace,
  pkgs,
  system,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.programs.graphical.sketchybar;
in
{
  options.programs.graphical.sketchybar = with types; {
    enable = mkBoolOpt false "enable sketchybar";
  };

  config = mkIf cfg.enable {
    services.sketchybar.enable = true;

    environment.systemPackages = with pkgs; [
      sbarlua
    ];

    home.file = {
      ".config/sketchybar" = {
        source = ./config/.;
        recursive = true;
        onChange = "${pkgs.sketchybar}/bin/sketchybar --reload";
      };
      ".local/share/sketchybar_lua/sketchybar.so" = {
        source = "${pkgs.sbarlua}/lib/lua/5.4/sketchybar.so";
        onChange = "${pkgs.sketchybar}/bin/sketchybar --reload";
      };
      ".config/sketchybar/sketchybarrc" = {
        text = ''
          #!/usr/bin/env ${pkgs.lua54Packages.lua}/bin/lua
          -- Load the sketchybar-package and prepare the helper binaries
          require("helpers")
          require("init")

          -- Enable hot reloading
          sbar.exec("sketchybar --hotload true")
        '';
        executable = true;
        onChange = "${pkgs.sketchybar}/bin/sketchybar --reload";
      };
    };
  };
}
