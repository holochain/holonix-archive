#!/usr/bin/env bats

# the clippy version should be roughly the rustc version
# most importantly clippy should exist
@test "clippy version" {
 result="$( cargo clippy --version )"
 echo $result
 [[ "$result" == *2019-11-14* || "$result" == *2020-03-17* ]]
}

@test "clippy smoke test" {
 hn-rust-clippy

 # the clippy target directory should have been created
 clippy_target_dir="$HC_TARGET_PREFIX/target/clippy"
 [[ "$clippy_target_dir" == "$PWD"/target/clippy ]]
 [ -d "$clippy_target_dir" ]
}
