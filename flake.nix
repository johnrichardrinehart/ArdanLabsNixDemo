{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/31ffc50c";
    flake-utils.url = "github:numtide/flake-utils/04c1b180862888302ddfb2e3ad9eaa63afc60cf8";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      rec {
        packages = rec {
          demoServer =
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

          default = packages.demoServer;
        };

        apps = rec {
          demoServer = flake-utils.lib.mkApp { drv = self.packages.${system}.demoServer; };
          default = demoServer;
        };

        devShell = import ./shell.nix { inherit pkgs; };
      }
    );
}
