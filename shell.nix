{ pkgs ? import <nixpkgs> { } }:
let
  p = pkgs;
in
p.mkShell {
  buildInputs = [
    p.nixpkgs-fmt
    p.go_1_16
  ];

  shellHook = ''
  '';
}
