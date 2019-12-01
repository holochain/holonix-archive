{ pkgs }:
let
  rust = import ./config.nix;
  rust-channel = (pkgs.rustChannelOfTargets rust.channel.name rust.channel.date [ rust.wasm-target rust.generic-linux-target  ]);
in
rust //
{
 buildInputs = []
 # https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/rust.section.md
 ++ [
  /* rust-channel.stable.cargo
  rust-channel.stable.rustc
  rust-channel.stable.rust-analysis
  rust-channel.stable.rust-src
  rust-channel.stable.rust-std */
  rust-channel
  pkgs.binutils
  pkgs.gcc
  pkgs.gnumake
  pkgs.openssl
  pkgs.pkgconfig
  pkgs.carnix
 ]
 ++ (pkgs.callPackage ./clippy { }).buildInputs
 ++ (pkgs.callPackage ./fmt { }).buildInputs
 ++ (pkgs.callPackage ./manifest { }).buildInputs
 ++ (pkgs.callPackage ./wasm { }).buildInputs
 ++ (pkgs.callPackage ./flush { }).buildInputs
 ;
}
