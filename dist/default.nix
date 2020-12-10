{ pkgs, rust, node, git, darwin }:
let
 config = import ./config.nix;

 lib = pkgs.callPackage ./lib.nix {
  dist = config;
  git = git;
  rust = rust;
  darwin = darwin;
  node = node;
 };

 holochain = pkgs.callPackage ./holochain {
  lib = lib;
 };

in
{
 # exposed derivations to allow nix-env install
 holochain = holochain;

 buildInputs =
 [
   pkgs.zlib
   pkgs.nix-prefetch-scripts
   pkgs.openssh
 ]
 ++ (pkgs.callPackage ./audit {
  dist = config;
  holochain = holochain;
  lib = lib;
  rust = rust;
 }).buildInputs

 ++ holochain.buildInputs
 ;
}
