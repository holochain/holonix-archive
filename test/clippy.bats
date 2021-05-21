#!/usr/bin/env bats

# the clippy version should be roughly the rustc version
# most importantly clippy should exist
@test "clippy version" {
 result="$( cargo clippy --version )"
 echo $result
 [[ "$result" == *0.1.51* ]]
}

@test "clippy smoke test" {
 # the clippy target directory should have been created
 clippy_target_dir="$CARGO_TARGET_DIR/clippy"
 [[ "$clippy_target_dir" == "$PWD"/target/clippy ]]
 [ -d "$clippy_target_dir" ]
}
