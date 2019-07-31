#!/usr/bin/env bats

@test "temp dir" {
 [[ $TMP == /tmp/tmp.* ]]
 [[ $TMPDIR == /tmp/tmp.* ]]
 [[ $TMP == $TMPDIR ]]
}

@test "watch is installed" {
 [[ $( watch -v ) == "watch from procps-ng 3.3.15" ]]
}
