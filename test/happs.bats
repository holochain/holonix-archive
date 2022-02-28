#!/usr/bin/env bats

@test "hApp scaffolding with hn-init" {
  hn-init
  cd my-app
  nix-shell --pure --run "npm i"
  nix-shell --pure --run "npm run test"
  nix-shell --pure --run "npm run package"
}
