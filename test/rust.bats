#!/usr/bin/env bats

# the mozilla nightly and upstream nightly can get out of sync!
# rustc reports the version that needs to match https://rust-lang.github.io/rustup-components-history/
@test "rustc version" {
 result="$( rustc --version )"
 echo $result
 [[ "$result" == *2019-11-15* ]]
}

# the clippy version should be roughly the rustc version
# most importantly clippy should exist
@test "clippy version" {
 result="$( cargo clippy --version )"
 echo $result
 [[ "$result" == *2019-11-14* ]]
}

# the rust fmt version should be roughly the rustc version
# most importantly fmt should exist
@test "fmt version" {
 result="$( cargo fmt --version )"
 echo $result
 [[ "$result" == *2019-10-07* ]]
}
