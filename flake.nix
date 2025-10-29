{
  description = "snowflake";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";

    snowfall-lib = {
      url = "https://flakehub.com/f/snowfallorg/lib/3.0.3";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";

    snowvim.url = "github:lalit64/snowvim";
    snowvim.inputs.nixpkgs.follows = "nixpkgs";
    snowvim.inputs.snowfall-lib.follows = "snowfall-lib";

    stylix.url = "https://flakehub.com/f/nix-community/stylix/*";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs =
    inputs:
    let
      lib = inputs.snowfall-lib.mkLib {
        inherit inputs;
        src = ./.;

        snowfall = {
          meta = {
            name = "snowflake";
            title = "Snowflake";
          };

          namespace = "snowflake";
        };
      };
      secrets =
        { lib, ... }:
        {
          age.secrets =
            with lib;
            listToAttrs (
              map (name: {
                name = removeSuffix ".age" name;
                value = {
                  file = (snowfall.fs.get-file "secrets/${name}");
                };
              }) (attrNames (import (snowfall.fs.get-file "secrets/secrets.nix")))
            );
        };
    in
    lib.mkFlake {
      inherit inputs;
      src = ./.;

      channels-config = {
        allowUnfree = true;
      };

      systems.modules.darwin = with inputs; [
        agenix.darwinModules.default
        secrets
      ];

      homes.modules = with inputs; [
        agenix.homeManagerModules.default
        secrets

        stylix.homeModules.default
      ];

      outputs-builder = channels: {
        formatter = channels.nixpkgs.nixpkgs-fmt;
      };
    };
}
