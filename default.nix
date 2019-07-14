# This is the default nix file FOR HOLONIX
# This file is what nix will find when hitting this repo as a tarball
# This means that downstream consumers should pkgs.callPackage this file
# See example.default.nix for an example of how to consume this file downstream
{
 # allow consumers to pass in their own config
 # fallback to empty sets
 config ? import ./config.nix
}:
let
 pkgs = import ./nixpkgs;

 app-spec-cluster = pkgs.callPackage ./app-spec-cluster { };
 conductor = pkgs.callPackage ./conductor { };
 darwin = pkgs.callPackage ./darwin { };
 rust = pkgs.callPackage ./rust { };
 git = pkgs.callPackage ./git { };
 dist = pkgs.callPackage ./dist {
  rust = rust;
  git = git;
 };
 n3h = pkgs.callPackage ./n3h { };
 node = pkgs.callPackage ./node { };
 openssl = pkgs.callPackage ./openssl { };
 qt = pkgs.callPackage ./qt { };
 release = pkgs.callPackage ./release {
  config = config;
 };

 holonix-shell = pkgs.callPackage ./nix-shell {
  pkgs = pkgs;
  app-spec-cluster = app-spec-cluster;
  conductor = conductor;
  darwin = darwin;
  dist = dist;
  git = git;
  n3h = n3h;
  node = node;
  openssl = openssl;
  qt = qt;
  release = release;
  rust = rust;
 };

 # override and overrideDerivation cannot be handled by mkDerivation
 derivation-safe-holonix-shell = (removeAttrs holonix-shell ["override" "overrideDerivation"]);
in
{
 pkgs = pkgs;
 # export the set used to build shell alongside the main derivation
 # downstream devs can extend/override the shell as needed
 # holonix-shell provides canonical dev shell for generic work
 shell = derivation-safe-holonix-shell;
 main = pkgs.stdenv.mkDerivation derivation-safe-holonix-shell;

 # needed for nix-env to discover install attributes
 holochain = {
  hc = dist.cli.derivation;
  holochain = dist.conductor.derivation;
 };

 # expose other things
 rust = rust;
}
