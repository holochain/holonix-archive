{ pkgs }:
let
  ## ie: hc-happ-scaffold <path-to-package-file> <app-name>
  name = "hc-happ-scaffold";

  script = pkgs.writeShellScriptBin name
  ''
    ''${1?"Command Usage Error: ARG 1 - PATH TO SCHEMA REQUIRED"}
    [[ $(mimetype -b "''${1}") != "application/json" ]] && { echo "Command Usage Error: ARG 1 - JSON FILE TYPE REQUIRED"; exit 1; }
    curl -L -o happ-scaffold.tar.gz https://github.com/holochain/RAD-Tools-Phase-2/archive/master.tar.gz
    mkdir "''${2:-"My-New-App"}"
    tar -zxvf happ-scaffold.tar.gz --strip-components=1 -C ./"''${2:-"My-New-App"}"
    rm happ-scaffold.tar.gz
    cd ''${2:-"My-New-App"}
    sed -i "s/RAD-Tools-Phase-2/"''${2:-"My-New-App"}"/g" package.json
    [ ! -d "./setup" ] && mkdir setup
    curl -L -o ./setup/type-spec.json "file:///$(readlink -f ../''${1})"
    [ -f "./sample-type-spec.json" ] && rm -rf ./sample-type-spec.json
    [ -d "./ui" ] && mv ./ui ./setup/ui-setup
    hc init dna-src
    mkdir ui-src
    npm i
    npm run hc-generate:dna
    npm run generate:ui
  '';
in
{
 buildInputs = [ script ];
}
