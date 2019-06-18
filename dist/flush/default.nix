{ pkgs, dist }:
let
  name = "hc-dist-flush";

  script = pkgs.writeShellScriptBin name
  ''
  rm -rf ${dist.path}
  '';
in
script
