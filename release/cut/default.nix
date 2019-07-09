{ pkgs }:
let
  name = "hn-release-cut";

  script = pkgs.writeShellScriptBin name
  ''
  set -euo pipefail
  echo
  read -r -p "Are you sure you want to cut a new release based on the current config? [y/N] " response
  case "$response" in
   [yY][eE][sS]|[yY])
    hn-release-branch
    hn-release-changelog
    hn-release-push
    hn-release-github
    ;;
   *)
    exit 1
    ;;
  esac
  '';
in
{
 buildInputs = [ script ];
}
