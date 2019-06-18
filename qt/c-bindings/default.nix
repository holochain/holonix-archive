{ pkgs }:
let
  flush = pkgs.callPackage ./nix/flush.nix { };
  test = pkgs.callPackage ./nix/test.nix { };
in
[
  flush
  test
]
