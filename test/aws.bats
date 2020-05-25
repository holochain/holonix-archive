#!/usr/bin/env bats

@test "saml2aws version" {

 result="$( command -v saml2aws )"
 [[ "$result" == "/nix/store/"*"-saml2aws-2.19.0/bin/saml2aws" ]]

}
