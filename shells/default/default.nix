{
  inputs,
  pkgs,
  system,
  ...
}:

pkgs.mkShell {
  nativeBuildInputs =
    (with pkgs; [
      age
      nixfmt-tree
      nixpkgs-fmt
      just
    ])
    ++ (with inputs; [
      agenix.packages.${system}.default
    ]);
}
