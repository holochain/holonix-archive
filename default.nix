# This is the default nix file FOR HOLONIX
# This file is what nix will find when hitting this repo as a tarball
# This means that downstream consumers should pkgs.callPackage this file
# See example.default.nix for an example of how to consume this file downstream
{
 # allow consumers to pass in their own config
 # fallback to empty sets
 config ? import ./config.nix,
}:
let
 pkgs = import ./pkgs;

 darwin = pkgs.callPackage ./darwin { };
 rust = pkgs.callPackage ./rust {
  inherit config;
 };

 node = pkgs.callPackage ./node { };
 git = pkgs.callPackage ./git { };
 linux = pkgs.callPackage ./linux { };
 dist = pkgs.callPackage ./dist {
  inherit
    rust
    node
    git
    darwin
    ;
 };
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
    dist
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
 };

 # override and overrideDerivation cannot be handled by mkDerivation
 derivation-safe-holonix-shell = (removeAttrs holonix-shell ["override" "overrideDerivation"]);
in
{
 inherit
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

 # needed for nix-env to discover install attributes
 holochain = {
  holochain = dist.holochain.derivation;
 };
}
