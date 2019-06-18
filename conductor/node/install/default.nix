{ pkgs }:
let
  name = "hc-conductor-node-install";

  script = pkgs.writeShellScriptBin name
  ''
  hc-node-flush
   ./scripts/build_nodejs_conductor.sh
  '';
in
{
 buildInputs = [ script ];
}
