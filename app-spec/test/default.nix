{ pkgs }:
let
  name = "hc-app-spec-test";

  script = pkgs.writeShellScriptBin name ''
  hc-cli-install \
  && hc-conductor-rust-install \
  && (cd app_spec && ./build_and_test.sh);
  '';
in
{
 buildInputs = [ script ];
}
