#!/usr/bin/env bats

setup() {
  BATS_TMPDIR="$(mktemp -d)"
}

teardown() {
  rm -rf "${BATS_TMPDIR:?}"
}

@test "hApp scaffolding with hn-init" {
  cd "${BATS_TMPDIR:?}"
  hn-init
  cd my-app
  nix-shell --pure --run "npm i"
  nix-shell --pure --run "npm run test"
  nix-shell --pure --run "npm run package"
}
