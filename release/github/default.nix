{ pkgs, config }:
let
 name = "hn-release-github";

 # inner script to build up the release notes
 notes-name = "hn-release-github-notes";
 heading-placeholder = "{{ version-heading }}";
 changelog-placeholder = "{{ changelog }}";
 notes-script = pkgs.writeShellScriptBin notes-name
 ''
 changelog=$( git show ${config.release.commit}:./CHANGELOG-UNRELEASED.md )
 heading_placeholder="${heading-placeholder}"
 heading="## [${config.release.version.current}] - $(date --iso --u)"
 changelog=''${changelog/$heading_placeholder/$heading}

 template=$( echo '${config.release.github.template}' )
 changelog_placeholder="${changelog-placeholder}"
 output=''${template/$changelog_placeholder/$changelog}
 echo "''${output}"
 '';

 # outer script to push the release notes to github
 description-generator = "$( ${notes-name} )";
 script = pkgs.writeShellScriptBin name
 ''
 export GITHUB_USER='${config.release.github.owner}'
 export GITHUB_REPO='${config.release.github.repo}'
 export GITHUB_TOKEN=$( git config --get hub.oauthtoken )
 echo
 echo 'Creating github release'
 echo
 github-release -v release --tag ${config.release.tag} --name ${config.release.tag} --description "${description-generator}"
 '';
in
{
 buildInputs = [ script notes-script ];
}
