{ pkgs }:
let
  rust = import ./config.nix;
in
rust //
{
 buildInputs = []
 # https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/rust.section.md
 ++ [
  (pkgs.rustChannelOfTargets "nightly" rust.nightly.date [ rust.wasm-target rust.generic-linux-target  ])
  pkgs.binutils
  pkgs.gcc
  pkgs.gnumake
  pkgs.openssl
  pkgs.pkgconfig
 ]
 ++ (pkgs.callPackage ./coverage { }).buildInputs
 ++ (pkgs.callPackage ./fmt { }).buildInputs
 ++ (pkgs.callPackage ./manifest { }).buildInputs
 ++ (pkgs.callPackage ./wasm { }).buildInputs
 ++ (pkgs.callPackage ./flush { }).buildInputs
 ++ (pkgs.callPackage ./test { rust = rust; }).buildInputs
 ;
}
