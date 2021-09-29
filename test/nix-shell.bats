#!/usr/bin/env bats

@test "temp dir" {
 [[ $TMP == /tmp/tmp.* ]]
 [[ $TMPDIR == /tmp/tmp.* ]]
 [[ $TMP == $TMPDIR ]]
}

@test "rust backtrace is set in shell" {
  [ "$RUST_BACKTRACE" == "1" ]
}

@test "default release tag is set" {
 [ "$RELEASE_VERSION" == "_._._" ]
 [ "$RELEASE_TAG" == "v_._._" ]
}

@test "hn-introspect lists holochain" {
 hn-introspect | egrep '.*- holochain: https://github.com/holochain/holochain/archive/.*.tar.gz.*'

}

@test "exclude components" {
 nix-shell --pure ./default.nix --arg include '{ holochainBinaries = false; node = false; happs = false; }' --run '
    for cmd in holochain hc node; do
        if type -f $cmd; then
            echo error: did not expect to find $cmd
            exit 1
        fi
    done
 '
}
