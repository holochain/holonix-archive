{ pkgs, config }:
let
  rust = import ./config.nix;
in
rust //
{
 buildInputs = []
 # https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/rust.section.md
 ++ [
  pkgs.binutils
  pkgs.gcc
  pkgs.gnumake
  pkgs.openssl
  pkgs.pkgconfig
  pkgs.carnix
  pkgs.cargo-make
  pkgs.curl
 ]
 ++ (if (builtins.hasAttr "holonix" config && config.holonix.use-stable-rust) then [ (pkgs.rustChannelOfTargets "stable" null [ rust.wasm-target rust.generic-linux-target  ]) ]
                                       else [ (pkgs.rustChannelOfTargets rust.channel.name rust.channel.date [ rust.wasm-target rust.generic-linux-target  ]) ])
 ++ (if pkgs.stdenv.isLinux then [ pkgs.kcov ] else [])
 ++ (pkgs.callPackage ./clippy { }).buildInputs
 ++ (pkgs.callPackage ./fmt { }).buildInputs
 ++ (pkgs.callPackage ./manifest { }).buildInputs
 ++ (pkgs.callPackage ./wasm { }).buildInputs
 ++ (pkgs.callPackage ./flush { }).buildInputs
 ;
}
