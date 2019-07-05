{ pkgs }:
let
  name = "hc-test";

  script = pkgs.writeShellScriptBin name
  ''
  hc-rust-fmt-check && hc-qt-c-bindings-test && hc-rust-test && hc-app-spec-test && hc-app-spec-test-proc
  '';
in
script
