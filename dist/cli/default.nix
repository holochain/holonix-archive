{ pkgs, lib }:
let
 config = import ./config.nix;
 derivation = (lib.binary-derivation config);
in
config // {
 buildInputs =
 [
 derivation
 ];
 derivation = derivation;
}
