#!/usr/bin/env bats

# @test "hc-happ-scaffold smoke test with json" {
#   FILE="./tmp"

#   # run the hc-happ-scaffold cmd
#   hc-happ-scaffold ./test/scaffold-test.json $FILE
#   # Checking if the folder was created
#   [[ -d "$FILE" ]]
#   [[ -f "$FILE/conductor-config.toml" ]]
#   [[ -f "$FILE/dna-src/dist/dna-src.dna.json" ]]
#   [[ -d "$FILE/ui-src" ]]
#   # remove the created happ
#   rm -rf "$FILE"
#   # Checking if the file was removed
#   ! [[ -d "$FILE" ]]
# }

@test "hc-happ-scaffold smoke test with url" {
  FILE="./tmp"

  # run the hc-happ-scaffold cmd
  hc-happ-scaffold https://tinyurl.com/ybgdhtwa $FILE
  # Checking if the folder was created
  [[ -d "$FILE" ]]
  [[ -f "$FILE/conductor-config.toml" ]]
  [[ -f "$FILE/dna-src/dist/dna-src.dna.json" ]]
  [[ -d "$FILE/ui-src" ]]
  # leave file for use in integration test
}

@test "hc-happ-scaffold integration test" {
  FILE="./tmp"

  # run generated happ integration tests
  cd $FILE
  # Checking that integration tests pass
  npm run ci:integration
  cd ..
  # remove the created happ
  rm -rf "$FILE"
  # Checking if the file was removed
  ! [[ -d "$FILE" ]]
}
