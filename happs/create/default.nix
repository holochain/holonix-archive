{ pkgs }:
let
  name = "hn-happ-create";

  script = pkgs.writeShellScriptBin name
  ''
    curl -L -o happ-template.tar.gz https://github.com/holochain/react-graphql-template/archive/master.tar.gz
    mkdir "''${1:-"Notes-hApp-Template"}"
    tar -zxvf happ-template.tar.gz --strip-components=1 -C ./"''${1:-"Notes-hApp-Template"}"
    rm happ-template.tar.gz
    cd ''${1:-"Notes-hApp-Template"}
    cp ui_src/.env.example ui_src/.env
    yarn hc:install
    yarn start
  '';
in
{
 buildInputs = [ script ];
}
