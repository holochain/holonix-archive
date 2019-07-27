#!/usr/bin/env bats

@test "temp dir" {
 [[ $TMP == /tmp/tmp.* ]]
 [[ $TMPDIR == /tmp/tmp.* ]]
 [[ $TMP == $TMPDIR ]]
}

@test "hc target prefix" {
  [[ $HC_TARGET_PREFIX == /tmp/tmp.*/nix-holochain/ ]]
}
