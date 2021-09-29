{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/31ffc50c";
  };

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.hello;
  };
}
