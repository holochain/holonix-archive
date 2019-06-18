{ pkgs }:
let
  name = "hc-app-spec-test-proc";

  script = pkgs.writeShellScriptBin name
  ''
  hc-conductor-node-install
   ( cd app_spec_proc_macro && ./build_and_test.sh )
  '';
in
{
 buildInputs = [ script ];
}
