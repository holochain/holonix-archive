{ pkgs, rust, git }:
let
 config = pkgs.callPackage ./config.nix { };

 lib = pkgs.callPackage ./lib.nix {
  dist = config;
 };

 cli = pkgs.callPackage ./cli {
  lib = lib;
 };

 conductor = pkgs.callPackage ./conductor {
  lib = lib;
 };
in
{
 buildInputs =
 [
   pkgs.nix-prefetch-scripts

   pkgs.callPackage ./audit {
    dist = config;
    cli = cli;
    conductor = conductor;
    lib = lib;
   }

   pkgs.callPackage ./dist { }

   pkgs.callPackage ./flush {
    dist = config;
   }
 ]

 ++ cli.buildInputs

 ++ conductor.buildInputs
 ;
}
