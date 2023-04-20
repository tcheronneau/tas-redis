{
description = "Devenv setup";
inputs = {
  nixpkgs.url = github:NixOS/nixpkgs/nixos-22.11;
};
outputs = { self, nixpkgs }:
let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in
  {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        pkgs.dgoss
        pkgs.docker
      ];
    };
  };
}
