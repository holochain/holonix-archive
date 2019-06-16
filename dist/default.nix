{ pkgs }:
let
 config = import ./config.nix;
 audit = pkgs.callPackage ./src/audit.nix { config = config; };
 dist = import ./src/dist.nix;
 flush = import ./src/flush.nix;
in
[
  pkgs.nix-prefetch-scripts

  audit
  dist
  flush
]
++ import ./cli/build.nix
++ import ./conductor/build.nix
