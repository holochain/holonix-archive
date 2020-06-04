#!/usr/bin/env bats

@test "scaffold smoke test with json" {
  FILE="./tmp"

  # run the scaffold cmd
  hc-happ-scaffold ./test/scaffold-test.json $FILE
  # Checking if the folder was created
  [[ -d "$FILE" ]]
  [[ -f "$FILE/conductor-config.toml" ]]
  [[ -f "$FILE/dna-src/dist/dna-src.dna.json" ]]
  [[ -d "$FILE/ui-src" ]]
  # remove the created happ
  rm -rf "$FILE"
  # Checking if the file was removed
  ! [[ -d "$FILE" ]]
}

@test "scaffold smoke test with url" {
  FILE="./tmp"

  # run the scaffold cmd
  hc-happ-scaffold https://tinyurl.com/ybgdhtwa $FILE
  # Checking if the folder was created
  [[ -d "$FILE" ]]
  [[ -f "$FILE/conductor-config.toml" ]]
  [[ -f "$FILE/dna-src/dist/dna-src.dna.json" ]]
  [[ -d "$FILE/ui-src" ]]
  # remove the created happ
  rm -rf "$FILE"
  # Checking if the file was removed
  ! [[ -d "$FILE" ]]
}
