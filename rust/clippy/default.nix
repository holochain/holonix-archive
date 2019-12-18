{ pkgs }:
let
 name = "hn-rust-clippy";

 script = pkgs.writeShellScriptBin name
 ''
 echo "submitting to the wrath of clippy"
 cargo fix -Z unstable-options --clippy --target-dir "$HC_TARGET_PREFIX"/target/clippy
 git diff-files --quiet
 '';
in
{
 buildInputs = [
  script
 ];
}
