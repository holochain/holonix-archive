{ pkgs }:
let

  name = "hn-docs-github-pages";

  path = "docs/public";
  upstream = "origin";
  branch = "gh-page";

  # https://stackoverflow.com/questions/36782467/set-subdirectory-as-website-root-on-github-pages#36782614
  script = pkgs.writeShellScriptBin name
  ''
set -euo pipefail
git subtree push --prefix ${path} ${origin} ${branch}
  '';
in
{
 buildInputs = [ script ];
}
