{ pkgs }:
let
  rust = import ./config.nix;
  build = (pkgs.rustChannelOfTargets "nightly" rust.nightly.date [ rust.wasm-target rust.generic-linux-target  ]);

  # coverage = pkgs.callPackage ./coverage { };
  # fmt = pkgs.callPackage ./fmt { };
  # manifest = pkgs.callPackage ./manifest { };
  # wasm = pkgs.callPackage ./wasm { };
in
rust //
{
 buildInputs =
 [ build ]
 # ++ coverage.buildInputs
 # ++ fmt.buildInputs
 # ++ manifest.buildInputs
 # ++ wasm.buildInputs
 # https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/rust.section.md
 ++ [
   pkgs.binutils
   pkgs.gcc
   pkgs.gnumake
   pkgs.openssl
   pkgs.pkgconfig
 ]
 ++ [
   (pkgs.callPackage ./flush { })
   (pkgs.callPackage ./test { })
 ];
}
