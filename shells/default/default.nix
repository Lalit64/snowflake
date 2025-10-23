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
      treefmt
    ])
    ++ (with inputs; [
      agenix.packages.${system}.default
    ]);
}
