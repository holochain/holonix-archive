{ pkgs }:
let

  name = "hn-docs-github-pages";

  path = "docs/public";
  upstream = "origin";
  from-branch = "2019-07-31-docs";
  to-branch = "gh-pages";

  # https://stackoverflow.com/questions/36782467/set-subdirectory-as-website-root-on-github-pages#36782614
  # https://clontz.org/blog/2014/05/08/git-subtree-push-for-deployment/
  # https://stackoverflow.com/questions/33172857/how-do-i-force-a-subtree-push-to-overwrite-remote-changes
  script = pkgs.writeShellScriptBin name
  ''
set -euo pipefail

if [[ -n $(git status --porcelain) ]]
 then echo "Repo is dirty! Commit changes before attempting to push to github pages." && exit 1
 else {
   ( cd docs && hugo && git add . && git commit -am'hugo build docs' )
   git push ${upstream} `git subtree split --prefix ${path} ${from-branch}`:${to-branch} --force
 }
fi
  '';
in
{
 buildInputs = [ script ];
}
