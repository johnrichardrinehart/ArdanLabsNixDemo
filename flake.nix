{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/31ffc50c";
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      defaultPackage.x86_64-linux = pkgs.hello;
      devShell = import ./shell.nix { inherit pkgs; };
    };
}
