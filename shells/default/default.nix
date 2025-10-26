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
      fh
    ])
    ++ (with inputs; [
      agenix.packages.${system}.default
    ]);
}
