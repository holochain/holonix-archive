#!/usr/bin/env bats

setup() {
  BATS_TMPDIR="$(mktemp -d)"
  cd "${BATS_TMPDIR:?}"
}

teardown() {
  cd ..
  rm -rf "${BATS_TMPDIR:?}"
}

@test "hApp scaffolding with hn-init" {
  hn-init
  cd my-app
  nix-shell --pure --run '
      npm i
      npm run test
      npm run package
  '
}
