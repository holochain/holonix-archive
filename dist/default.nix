{ pkgs, rust, node, git }:
let
 config = import ./config.nix;

 lib = pkgs.callPackage ./lib.nix {
  dist = config;
  git = git;
  rust = rust;
 };

 conductor = pkgs.callPackage ./conductor {
  lib = lib;
 };

 cli = pkgs.callPackage ./cli {
  lib = lib;
  conductor = conductor;
  node = node;
  git = git;
  rust = rust;
 };
in
{
 # exposed derivations to allow nix-env install
 cli = cli;
 conductor = conductor;

 buildInputs =
 [
   pkgs.nix-prefetch-scripts
 ]
 ++ (pkgs.callPackage ./audit {
  dist = config;
  cli = cli;
  conductor = conductor;
  lib = lib;
  rust = rust;
 }).buildInputs

 ++ (pkgs.callPackage ./dist { }).buildInputs

 ++ (pkgs.callPackage ./flush {
  dist = config;
 }).buildInputs

 ++ cli.buildInputs

 ++ conductor.buildInputs
 ;
}
