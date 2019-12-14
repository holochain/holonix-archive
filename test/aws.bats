#!/usr/bin/env bats

@test "saml2aws version" {

 result="$( command -v saml2aws )"
 [[ "$result" == "/nix/store/"*"-saml2aws-2.15.0-bin/bin/saml2aws" ]]

}
