{ pkgs }:
let
  name = "hc-conductor-rust-install";

  script = pkgs.writeShellScriptBin name
  ''
  cargo build -p holochain --release && cargo install -f --path conductor
  '';
in
{
 buildInputs = [ script ];
}
