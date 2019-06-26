let
 pkgs = import ./nixpkgs;

 app-spec = pkgs.callPackage ./app-spec { };
 app-spec-cluster = pkgs.callPackage ./app-spec-cluster { };
 cli = pkgs.callPackage ./cli { };
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

 holonix-shell = pkgs.callPackage ./nix-shell {
  pkgs = pkgs;
  app-spec = app-spec;
  app-spec-cluster = app-spec-cluster;
  cli = cli;
  conductor = conductor;
  darwin = darwin;
  dist = dist;
  git = git;
  n3h = n3h;
  node = node;
  openssl = openssl;
  qt = qt;
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
