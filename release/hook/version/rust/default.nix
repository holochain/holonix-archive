{ pkgs, config }:
let
 name = "hn-release-hook-version-rust";

 script = pkgs.writeShellScriptBin name ''
echo "bumping Cargo versions from ${config.release.version.previous} to ${config.release.version.current} in Cargo.toml"
find . \
 -name "Cargo.toml" \
 -not -path "**/.git/**" \
 -not -path "**/.cargo/**" | xargs -I {} \
 sed -i 's/^\s*version\s*=\s*"${config.release.version.previous}"\s*$/version = "${config.release.version.current}"/g' {}
'';
in
{
 buildInputs = [ script ];
}
