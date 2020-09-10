{ pkgs }:
let
 name = "hn-rust-clippy";

 script = pkgs.writeShellScriptBin name
 ''
 cargo clippy --target-dir "$HC_TARGET_PREFIX"/target/clippy -- \
 -A clippy::nursery -D clippy::style -A clippy::cargo \
 -A clippy::pedantic -A clippy::restriction \
 -D clippy::complexity -D clippy::perf -D clippy::correctness
 '';
in
{
 buildInputs = [
  script
 ];
}
