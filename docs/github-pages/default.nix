{ pkgs }:
let

  name = "hn-docs-github-pages";

  path = "docs/public";
  upstream = "origin";
  branch = "gh-pages";

  # https://stackoverflow.com/questions/36782467/set-subdirectory-as-website-root-on-github-pages#36782614
  script = pkgs.writeShellScriptBin name
  ''
set -euo pipefail

if [[ -n $(git status --porcelain) ]]
 then echo "Repo is dirty! Commit changes before attempting to push to github pages." && exit 1
 else git subtree push --prefix ${path} ${upstream} ${branch}
fi
  '';
in
{
 buildInputs = [ script ];
}
