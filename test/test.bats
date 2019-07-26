#!/usr/bin/env bats

@test "github-release version" {
 result="$( github-release version )"
 [ "$result" == "1.2.4" ]
}

@test "rust backtrace is set in shell" {
  [ "$RUST_BACKTRACE" == "1" ]
}
