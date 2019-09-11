#!/usr/bin/env bats

@test "temp dir" {
 [[ $TMP == /tmp/tmp.* ]]
 [[ $TMPDIR == /tmp/tmp.* ]]
 [[ $TMP == $TMPDIR ]]
}

@test "watch is installed" {
 [[ $( watch -v ) == "watch from procps-ng 3.3.15" ]]
 }

@test "rust backtrace is set in shell" {
  [ "$RUST_BACKTRACE" == "1" ]
}

@test "default release tag is set" {
 [ "$RELEASE_VERSION" == "_._._" ]
 [ "$RELEASE_TAG" == "v_._._" ]
}
