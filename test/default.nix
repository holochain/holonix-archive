{ pkgs }:
let
 # self tests for holonix
 # mostly smoke tests on various platforms
 name = "hn-test";

 script = pkgs.writeShellScriptBin name
 ''
set -euxo pipefail

 '';
in
{
 buildInputs = [
  script
 ];
}
