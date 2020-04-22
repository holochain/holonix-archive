{ pkgs }:
let
  # ie: hc-happ-scaffold <path-to-package-file> <app-name>
  name = "hc-happ-scaffold";

  # nb: currently the curling from wip branch on rad-tool-phase2. Will eventually need to repoint to master branch.
  script = pkgs.writeShellScriptBin name
  ''
    ''${1?"Command Usage Error: ARG 1 - PATH TO SCHEMA REQUIRED"}
    [[ $(mimetype -b "''${1}") != "application/json" ]] && { echo "Command Usage Error: ARG 1 - JSON FILE TYPE REQUIRED"; exit 1; }
    STARTING_DIRECTORY=$(pwd -P)
    curl -L -o happ-scaffold.tar.gz https://github.com/holochain/RAD-Tools-Phase-2/archive/merge-first-ui-w-first-dna.tar.gz
    mkdir "''${2:-"My-New-App"}"
    tar -zxvf happ-scaffold.tar.gz --strip-components=1 -C ./"''${2:-"My-New-App"}"
    rm happ-scaffold.tar.gz
    cd ''${2:-"My-New-App"}
    sed -i "s/RAD-Tools-Phase-2/"''${2:-"My-New-App"}"/g" package.json
    [ ! -d "./setup" ] && mkdir setup
    curl -L -o ./setup/type-spec.json "file://$(readlink -f $(realpath --relative-to=$(pwd -P) $STARTING_DIRECTORY)/''${1})"
    [ -f "./sample-type-spec.json" ] && rm -rf ./sample-type-spec.json
    [ -d "./ui" ] && mv ./ui ./setup/ui-setup
    cd ./setup/ui-setup/ui_template && npm i && cd ../../../
    mkdir ui-src
    mkdir keystores
    mkdir keystores/agent1
    cp ./.env.example ./.env
    mv ./conductor-config.example.toml ./conductor-config.toml
    hc keygen -n --path ./keystores/agent1/AGENT_1_PUB_KEY.keystore | sed -ne 's/^Public address:\.*//p' | xargs -I {} sh -c 'mv ./keystores/agent1/AGENT_1_PUB_KEY.keystore ./keystores/agent1/{}.keystore; sed -i "s/AGENT_1_PUB_KEY/{}/" ./conductor-config.toml'
    npm i
    npm run generate:ui
    hc init dna-src
    npm run hc-generate:dna
    cd dna-src
    hc package | sed -ne 's/^DNA hash: \.*//p' | xargs -I {} sed -i "s/DNA_HASH/{}/" ../conductor-config.toml
    cd ../setup
    rm -rf dna-setup
    rm -rf ui-setup
  '';
in
{
 buildInputs = [ script ];
}
