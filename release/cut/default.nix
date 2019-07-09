{ pkgs }:
let
  name = "hn-release-cut";

  script = pkgs.writeShellScriptBin name
  ''
  echo
  read -r -p "Are you sure you want to cut a new release based on the current config? [y/N] " response
  case "$response" in
   [yY][eE][sS]|[yY])
    hn-release-branch \
    && hn-release-changelog \
    && hn-release-push
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
