{ config
, stdenv
, writeShellScriptBin
, bats
, nix
}:
let
  # self tests for holonix
  # mostly smoke tests on various platforms
  name = "hn-test";

  script = writeShellScriptBin name ''
    set -e

    bats ./test/clippy.bats
    # TODO: revisit when decided on a new gihtub-release binary
    # bats ./test/github-release.bats

    bats ./test/nix-shell.bats
    ${if stdenv.isLinux then "bats ./test/perf.bats" else ""}
    bats ./test/rust-manifest-list-unpinned.bats
    bats ./test/rust.bats
    bats ./test/flamegraph.bats
    bats ./test/scaffolding.bats
    bats ./test/holochain-binaries.bats
  '';

in
{
  buildInputs = [
    script
    # test system for bash
    # https://github.com/sstephenson/bats
    bats

    nix
  ];
}
