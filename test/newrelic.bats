#!/usr/bin/env bats

@test "pcre-config version" {

 result="$( command -v pcre-config )"
 [[ "$result" == "/nix/store/"*"-pcre-8.43-dev/bin/pcre-config" ]]

}
