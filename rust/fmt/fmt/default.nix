{ pkgs }:
let
 name = "hc-rust-fmt";

 script = pkgs.writeShellScriptBin name
 ''
 cargo fmt
 '';
in
{
 buildInputs = [ script ];
}
