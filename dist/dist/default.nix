{ pkgs }:
let
 name = "hc-dist";

 script = pkgs.writeShellScriptBin name
 ''
 hc-cli-dist
 hc-conductor-node-dist
 hc-conductor-rust-dist
 '';
in
{
 buildInputs = [ script ];
}
