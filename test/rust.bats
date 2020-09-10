#!/usr/bin/env bats

# the mozilla nightly and upstream nightly can get out of sync!
# rustc reports the version that needs to match https://rust-lang.github.io/rustup-components-history/
@test "rustc version" {
 result="$( rustc --version )"
 echo $result
 [[ "$result" == *2019-11-15* || "$result" == *2020-04-20* ]]
}

# the rust fmt version should be roughly the rustc version
# most importantly fmt should exist
@test "fmt version" {
 result="$( cargo fmt --version )"
 echo $result
 [[ "$result" == *2019-10-07* || "$result" == *2020-03-11* ]]
}

# RUSTFLAGS should be set correctly
@test "RUSTFLAGS value" {
 result="$( echo $RUSTFLAGS )"
 echo $result
 [[ "$result" == '-D warnings -Z external-macro-backtrace -Z thinlto -C codegen-units=10' || "$result" == '-D warnings -C codegen-units=10' ]]
}
