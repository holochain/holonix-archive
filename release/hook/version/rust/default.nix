{ pkgs, config }:
let
 name = "hn-release-hook-version-rust";

 script = pkgs.writeShellScriptBin name ''
echo "bumping Cargo versions to ${config.release.version.current} in Cargo.toml"
find . \
 -name "Cargo.toml" \
 -not -path "**/.git/**" \
 -not -path "**/.cargo/**" | xargs -I {} \
 sed -i 's/^\s*version\s*=\s*"[0-9]\+.[0-9]\+.[0-9]\+\(-alpha[0-9]\+\)\?"\s*$/version = "${config.release.version.current}"/g' {}
'';
in
{
 buildInputs = [ script ];
}
