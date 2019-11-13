{ pkgs, lib }:
let
 config = import ./config.nix;
in
config // rec {
 derivation = (lib.binary-derivation config);
 buildInputs =
 [
  derivation
 ]
 ;
}
