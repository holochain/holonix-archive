# This is the default nix file FOR HOLONIX
# This file is what nix will find when hitting this repo as a tarball
# This means that downstream consumers should pkgs.callPackage this file
# See example.default.nix for an example of how to consume this file downstream
{
 # allow consumers to pass in their own config
 # fallback to empty sets
 config ? import ./config.nix
 , holo-nixpkgs ? import (fetchTarball {
   url = "https://github.com/Holo-Host/holo-nixpkgs/archive/7663ff8421a6504cd02658b1d5c44c52e307f001.tar.gz";
   sha256 = "0adz6gip6pkx332yh3l7qg47kkgxmfxvdzyfvmkrxq2p3sv2bd6g";
 }) {}
 , includeHolochainBinaries ? true
}:
let
 pkgs = import holo-nixpkgs.path {
  overlays = holo-nixpkgs.overlays
    ++ [
      (self: super: {
        holonix = self.callPackage ./pkgs/holonix.nix { };
      })
    ]
    ;
};

 darwin = pkgs.callPackage ./darwin { };
 rust = pkgs.callPackage ./rust {
  inherit config;
 };

 node = pkgs.callPackage ./node { };
 git = pkgs.callPackage ./git { };
 linux = pkgs.callPackage ./linux { };
 docs = pkgs.callPackage ./docs { };
 openssl = pkgs.callPackage ./openssl { };
 release = pkgs.callPackage ./release {
  config = config;
 };
 test = pkgs.callPackage ./test {
   inherit
    pkgs
    config
    ;
 };
 happs = pkgs.callPackage ./happs { };

 holonix-shell = pkgs.callPackage ./nix-shell {
  inherit
    pkgs
    darwin
    docs
    git
    linux
    node
    openssl
    release
    rust
    test
    happs
    ;
  extraBuildInputs = [
    ]
    ++ (
      if includeHolochainBinaries
      then with pkgs; [
        holochain
        dna-util
        lair-keystore
        kitsune-p2p-proxy
      ]
      else []
      )
    ;
 };

 # override and overrideDerivation cannot be handled by mkDerivation
 derivation-safe-holonix-shell = (removeAttrs holonix-shell ["override" "overrideDerivation"]);

in rec
{
 inherit
  holo-nixpkgs
  pkgs
  # expose other things
  rust
  darwin
  ;

 # export the set used to build shell alongside the main derivation
 # downstream devs can extend/override the shell as needed
 # holonix-shell provides canonical dev shell for generic work
 shell = derivation-safe-holonix-shell;
 main = pkgs.mkShell derivation-safe-holonix-shell;
}
