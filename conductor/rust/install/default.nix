{ pkgs }:
let
  name = "hc-conductor-rust-install";

  script = pkgs.writeShellScriptBin name
  ''
  cargo build -p holochain && cargo install -f --path conductor
  '';
in
{
 buildInputs = [ script ];
}
