{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    neovim.url = "git+ssh://git@github.com/lalit64/nvim.git";
    neovim.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nix-vscode-extensions.url = "git+ssh://git@github.com/nix-community/nix-vscode-extensions?rev=bcf7577daac02aa1a7dfaddc79324b7c6ca4af81";

    lalit64-nur.url = "git+ssh://git@github.com/lalit64/nur.git";
    lalit64-nur.inputs.nixpkgs.follows = "nixpkgs";
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
    in
    lib.mkFlake {
      inherit inputs;
      src = ./.;

      channels-config = {
        allowUnfree = true;
      };

      systems.modules.darwin = with inputs; [
        neovim.nixosModules.default
        sops-nix.darwinModules.sops
      ];
    };
}
