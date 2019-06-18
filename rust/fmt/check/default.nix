{ pkgs }:
let
 name = "hc-rust-fmt-check";

 script = pkgs.writeShellScriptBin name
 ''
 cargo fmt -- --check
 '';
in
{
 buildInputs = [ script ];
}
