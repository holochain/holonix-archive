{ pkgs, lib }:
let
 config = import ./config.nix;
in
config // {
 buildInputs =
 [
   (lib.binary-derivation config)
 ]
 ;
}
