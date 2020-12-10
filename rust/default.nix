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
  pkgs.cargo-make
  pkgs.curl
 (pkgs.rustChannelOfTargets
    # channel, accepts stable versions. e.g. "1.45.2"
    rust.version
    # date
    null
    # targets
    [ rust.wasm-target rust.generic-linux-target ]
  )
 ]
 ++ (if pkgs.stdenv.isLinux then [ pkgs.kcov ] else [])
 ++ (pkgs.callPackage ./clippy { }).buildInputs
 ++ (pkgs.callPackage ./fmt { }).buildInputs
 ++ (pkgs.callPackage ./manifest { }).buildInputs
 ++ (pkgs.callPackage ./flush { }).buildInputs
 ;
}
