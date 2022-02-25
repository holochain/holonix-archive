#!/usr/bin/env bats

@test "hApp scaffolding with hn-init" {
  hn-init
  cd my-app
  npm i
  npm run test
  npm run package
}
