{
  config,
  lib,
  namespace,
  pkgs,
  system,
  inputs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.programs.graphical.editors.zed;
in
{
  options.programs.graphical.editors.zed = with types; {
    enable = mkBoolOpt false "enable zed";
  };

  config = mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;

      extraPackages = with pkgs; [ nixd ];

      extensions = [
        "nix"
        "toml"
        "lua"
      ];

      userSettings = {
        base_keymap = "Atom";
        vim_mode = true;

        buffer_font_family = mkIf (!config.theme.stylix.enable) "JetBrainsMono NF";
        buffer_font_size = mkIf (!config.theme.stylix.enable) 16;
        buffer_line_height = "comfortable";

        project_panel = {
          dock = "right";
        };

        format_on_save = "on";
        formatter = "language_server";

        lsp = {
          nixd = {
            settings = {
              nixpkgs = {
                expr = ''
                  let
                    flake = builtins.getFlake (builtins.toString ./.);
                    real = flake.inputs.nixpkgs;
                    lib = flake.lib or real.lib;

                    nixpkgs = real // {
                      lib = lib;
                      outputs.lib = lib;
                    };
                  in (import nixpkgs { })
                '';
              };
              options = {
                nixd = {
                  expr = /* nix */ ''
                    let
                      flake = builtins.getFlake (builtins.toString ./.);
                      default = {
                        users.type.getSubOptions = options: { };
                      };
                      lib = flake.lib or flake.inputs.nixpkgs.lib;

                      darwin = (builtins.attrValues (flake.darwinConfigurations or { }));
                      nixos = (builtins.attrValues (flake.nixosConfigurations or { }));
                      home = (builtins.attrValues (flake.homeConfigurations or { }));
                      all = darwin ++ nixos ++ home;

                      home-manager-options = flake: (flake.options.home-manager or default).users.type.getSubOptions [ ];
                      home-manager = builtins.foldl' (acc: elem: acc // (home-manager-options elem)) { } all;

                      systems = builtins.foldl' (acc: elem: acc // elem.options) { } all;

                      final-flake = flake // {
                        lib = lib;
                        self = flake;
                      };

                      final = ((home-manager // systems) // final-flake);
                    in final
                  '';
                };
              };
            };
          };
        };

        languages = {
          Nix = {
            language_servers = [
              "nixd"
              "!nil"
            ];
          };
        };

        disable_ai = true;
        confirm_quit = false;
      };
    };
  };
}
