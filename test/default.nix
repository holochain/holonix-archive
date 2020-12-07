{ pkgs, config }:
let
 # self tests for holonix
 # mostly smoke tests on various platforms
 name = "hn-test";

 script = pkgs.writeShellScriptBin name ''
# TODO: find out if we still need this
# bats ./test/aws.bats
bats ./test/clippy.bats
# TODO: revisit when decided on a new gihtub-release binary
# bats ./test/github-release.bats

# TODO: find out if we need new relic, if so, ensure newrelic ships its dependnecies reliably
# bats ./test/newrelic.bats
bats ./test/nix-shell.bats
${if pkgs.stdenv.isLinux then "bats ./test/perf.bats" else ""}
bats ./test/rust-manifest-list-unpinned.bats
bats ./test/rust.bats
bats ./test/flamegraph.bats
# TODO: refactor the happ scaffolding tests for RSM
# ${if config.holonix.use-stable-rust == false then "bats ./test/happs.bats" else ""}
'';

in
{
 buildInputs = [
  script
  # test system for bash
  # https://github.com/sstephenson/bats
  pkgs.bats
 ];
}
