{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/31ffc50c";
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      defaultPackage.x86_64-linux =
        let
          lib = pkgs.lib;
        in
        pkgs.buildGoModule {
          pname = "ArdanLabsNixDemo";
          version = "0.0.2";

          modSha256 = lib.fakeSha256;
          vendorSha256 = null;

          src = ./.;

          meta = {
            description = "World's simplest HTTP server to demonstrate how to package Go applications with Nix";
            homepage = "https://github.com/johnrichardrinehart/ArdanLabsNixDemo";
            license = lib.licenses.mit;
            maintainers = [ "johnrichardrinehart" ];
            platforms = lib.platforms.linux ++ lib.platforms.darwin;
          };
        };

      devShell = import ./shell.nix { inherit pkgs; };
    };
}
