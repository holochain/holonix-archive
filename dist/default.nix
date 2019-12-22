{ pkgs, rust, node, git, darwin }:
let
 config = import ./config.nix;

 lib = pkgs.callPackage ./lib.nix {
  dist = config;
  git = git;
  rust = rust;
  darwin = darwin;
  node = node;
 };

 holochain = pkgs.callPackage ./holochain {
  lib = lib;
 };

 sim2h_server = pkgs.callPackage ./sim2h_server {
  lib = lib;
 };

 trycp_server = pkgs.callPackage ./trycp_server {
  lib = lib;
  holochain = holochain;
 };

 cli = pkgs.callPackage ./cli {
  lib = lib;
  holochain = holochain;
  node = node;
  git = git;
  rust = rust;
 };
in
{
 # exposed derivations to allow nix-env install
 cli = cli;
 holochain = holochain;
 sim2h_server = sim2h_server;
 trycp_server = trycp_server;

 buildInputs =
 [
   pkgs.zlib
   pkgs.nix-prefetch-scripts
   pkgs.openssh
 ]
 ++ (pkgs.callPackage ./audit {
  dist = config;
  cli = cli;
  holochain = holochain;
  sim2h_server = sim2h_server;
  trycp_server = trycp_server;
  lib = lib;
  rust = rust;
 }).buildInputs

 ++ cli.buildInputs
 ++ holochain.buildInputs
 ++ sim2h_server.buildInputs
 ++ trycp_server.buildInputs
 ;
}
