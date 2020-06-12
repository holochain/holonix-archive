{ pkgs }:
let
  # ie: hc-happ-scaffold <path-to-package-file> <path-to-new-happ-dir>
  name = "hc-happ-scaffold";

  script = pkgs.writeShellScriptBin name
  ''
    ''${1?"Command Usage Error: ARG 1 - PATH TO SCHEMA REQUIRED"}
    IS_URL=false
    [[ $(file -b -N --mime-type "''${1}") != "application/json" ]] && {
      if [[ $1 =~ https?://.* ]]; then
        IS_URL=true
      else
        echo "Command Usage Error: ARG 1 - JSON FILE OR URL TYPE REQUIRED";
        exit 1;
      fi
    }
    STARTING_DIRECTORY=$(pwd -P)
    curl -L -o happ-scaffold.tar.gz https://github.com/holochain/RAD-Tools-Phase-2/archive/master.tar.gz
    mkdir "''${2:-"My-New-App"}"
    tar -zxvf happ-scaffold.tar.gz --strip-components=1 -C ./"''${2:-"My-New-App"}"
    rm happ-scaffold.tar.gz
    cd ''${2:-"My-New-App"}
    [ ! -d "./src/setup" ] && mkdir ./src/setup
    [ ! -d "./src/setup/type-specs" ] && mkdir ./src/setup/type-specs
    [ -f "./src/setup/type-specs/type-spec.json" ] && rm -rf ./src/setup/type-specs/type-spec.json
    if [[ "$IS_URL" = true ]]; then
      curl -L -o ./src/setup/type-specs/type-spec.json "''${1}"
    else
      curl -L -o ./src/setup/type-specs/type-spec.json "file://$(readlink -f $(realpath --relative-to=$(pwd -P) $STARTING_DIRECTORY)/''${1})"
    fi
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
 buildInputs = [ script pkgs.file ];
}
