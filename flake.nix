{
  description = "snowflake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    neovim.url = "git+ssh://git@github.com/lalit64/nvim.git";
    neovim.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";

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

        neovim.nixosModules.default
      ];

      homes.modules = with inputs; [
        agenix.homeManagerModules.default
        secrets
      ];
    };
}
