#!/usr/bin/env bats

@test "expected holochain version available" {
  result="$(holochain --version)"
  echo $result
  [[ "$result" == *" 0.0.107" ]]
}

@test "expected hc version available" {
  result="$(hc --version)"
  echo $result
  [[ "$result" == *" 0.0.8" ]]
}

@test "expected lair-keystore version available" {
  result="$(lair-keystore --version)"
  echo $result
  [[ "$result" == *" 0.0.4" ]]
}

@test "expected kitsune-p2p-proxy version available" {
  result="$(kitsune-p2p-proxy --version)"
  echo $result
  [[ "$result" == *" 0.0.6" ]]
}
