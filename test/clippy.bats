#!/usr/bin/env bats

# the clippy version should be roughly the rustc version
# most importantly clippy should exist
@test "clippy version" {
 result="$( cargo clippy --version )"
 echo $result
 [[ "$result" == *2019-11-14* ]]
}

@test "clippy smoke test" {
 hn-rust-clippy
}
