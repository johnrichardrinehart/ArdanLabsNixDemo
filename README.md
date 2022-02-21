Ardan Labs Nix Demo
===================

## High-Level Overview
We bumbled the scheduling of an earlier presentation about `git worktree` that a
few co-workers attended.  In efforts to amend this failure we decided to
schedule a new presentation about `nix` (language, `flake`s, package manager,
and operating system). In order to provide something "tangible" for the
engineers I set up this repository with a very simple HTTP server (spawns on a
random port and responds to any request with a 200).

## Usage
If you already have the `nix` package manager installed and/or are using `NixOS`
and are using `nix>=2.4` (for `flake` support) then running this server is as
easy as
```bash
nix run github:johnrichardrinehart/ArdanLabsNixDemo
```

Otherwise, if you have a compatible operating system you can try to grab
[nix-portable](https://github.com/DavHau/nix-portable) and execute like the
following
```bash
curl -L -o nix-portable https://github.com/DavHau/nix-portable/releases/download/v008/nix-portable
chmod +x ./nix-portable
./nix-portable nix run github:johnrichardrinehart/ArdanLabsNixDemo
```

Note: As of time of writing `nix` flakes are still an experimental (yet stable)
feature. To use them it may be necessary to modify the above command to
```bash
./nix-portable nix run github:johnrichardrinehart/ArdanLabsNixDemo -extra-experimental-features nix-command --extra-experimental-features flakes
```
