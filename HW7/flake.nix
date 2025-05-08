{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      self,
      nixpkgs,
      utils,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        buildInputs = [
          (pkgs.python313.withPackages (
            ps: with ps; [
              numpy
              sympy
            ]
          ))
        ];
      in
      {
        devShell = pkgs.mkShell {
          inherit buildInputs;
          packages = [
            pkgs.black
          ];
        };
      }
    );
}
