{ pkgs }:
let
 name = "hn-rust-clippy";

 script = pkgs.writeShellScriptBin name
 ''
 echo "submitting to the wrath of clippy"
 cargo clippy -- \
 -A clippy::nursery -A clippy::style -A clippy::cargo \
 -A clippy::pedantic -A clippy::restriction \
 -D clippy::complexity -D clippy::perf -D clippy::correctness
 '';
in
{
 buildInputs = [
  script
 ];
}
