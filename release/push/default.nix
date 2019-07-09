{ pkgs, config }:
let
  name = "hn-release-push";

  script = pkgs.writeShellScriptBin name
  ''
  echo
  echo
  echo "kicking off release"
  echo
  if [ "$(git rev-parse --abbrev-ref HEAD)" == "${config.release.branch}" ]
   then
    git add . && git commit -am 'Release ${config.release.tag}'
    git push
    git pull ${config.release.upstream} master
    git push ${config.release.upstream} HEAD:master
    git pull ${config.release.upstream} develop
    git push ${config.release.upstream} HEAD:develop
    echo
    echo "releasing core ${config.release.tag}"
    echo
    echo "tagging ${config.release.tag}"
    git tag -a ${config.release.tag} -m "Version ${config.release.tag}"
    git push ${release.upstream} ${config.release.tag}
    echo
    echo "release tags pushed"
   else
    echo "current branch is not ${config.release.branch}!";
    echo "try running hn-release-cut for the full process or hn-release-branch"
    exit 1;
  fi


  git checkout master
  git pull
  '';
in
{
 buildInputs = [ script ];
}
