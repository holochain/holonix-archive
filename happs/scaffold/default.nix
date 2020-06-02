{ pkgs }:
let
  # ie: hc-happ-scaffold <path-to-package-file> <app-name>
  name = "hc-happ-scaffold";

  # nb: currently the curling from wip branch on integration-testing-tryorama-fix-1. Will eventually need to repoint to master branch, once merged.
  script = pkgs.writeShellScriptBin name
  ''
    ''${1?"Command Usage Error: ARG 1 - PATH TO SCHEMA REQUIRED"}
    [[ $(mimetype -b "''${1}") != "application/json" ]] && { echo "Command Usage Error: ARG 1 - JSON FILE TYPE REQUIRED"; exit 1; }
    STARTING_DIRECTORY=$(pwd -P)
    curl -L -o happ-scaffold.tar.gz https://github.com/holochain/RAD-Tools-Phase-2/archive/master.tar.gz
    mkdir "''${2:-"My-New-App"}"
    tar -zxvf happ-scaffold.tar.gz --strip-components=1 -C ./"''${2:-"My-New-App"}"
    rm happ-scaffold.tar.gz
    cd ''${2:-"My-New-App"}
    [ ! -d "./src/setup" ] && mkdir ./src/setup
    [ ! -d "./src/setup/type-specs" ] && mkdir ./src/setup/type-specs
    [ -f "./src/setup/type-specs/type-spec.json" ] && rm -rf ./src/setup/type-specs/type-spec.json
    curl -L -o ./src/setup/type-specs/type-spec.json "file://$(readlink -f $(realpath --relative-to=$(pwd -P) $STARTING_DIRECTORY)/''${1})"
    [ ! -f "./src/setup/type-specs/sample-type-spec.json" ] &&  cp ./src/setup/type-specs/type-spec.json ./src/setup/type-specs/sample-type-spec.json
    npm i
    npm run happ:generate ./src/setup/type-specs/type-spec.json
    rm -rf ./src ./package.json ./config.nix ./default.nix README.md ./CHANGELOG.md ./node_modules
    mv ./happ/* ./
    rm -rf ./happ

    npm i
  '';
in
{
 buildInputs = [ script ];
}

# sed -i "s/happ-name/"''${2:-"My-New-App"}"/g" ./package.json
# sed -i "s/happ-name/"''${2:-"My-New-App"}"/g" ./ui-src/package.json