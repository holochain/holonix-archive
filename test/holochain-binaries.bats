#!/usr/bin/env bats

@test "expected holochain version available" {
  result="$(holochain --version)"
  echo $result
  [[ "$result" == *" 0.0.1" ]]
}

@test "expected dna-util version available" {
  result="$(dna-util --version)"
  echo $result
  [[ "$result" == *" 0.0.1" ]]
}

@test "expected lair-keystore version available" {
  result="$(lair-keystore --version)"
  echo $result
  [[ "$result" == *" 0.0.1-alpha.10" ]]
}
