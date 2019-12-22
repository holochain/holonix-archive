{ pkgs, lib, holochain }:
let
 config = import ./config.nix;
in
config // rec {
 derivation = (lib.binary-derivation (config // {
  deps = [ ]
  ++ holochain.buildInputs;
 }));
 buildInputs =
 [
  derivation
 ]
 ;
}
