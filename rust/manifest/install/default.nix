{ pkgs }:
let
 name = "hc-rust-manifest-install";

 script = pkgs.writeShellScriptBin name
 ''
 cargo install cargo-edit
 '';
in
{
 buildInputs = [ script ];
}
