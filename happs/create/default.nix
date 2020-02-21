{ pkgs }:
let
  name = "hn-happ-create";

  script = pkgs.writeShellScriptBin name
  ''
    curl -L -o happ-template.tar.gz https://github.com/holochain/react-graphql-template/archive/convenient-scripts.tar.gz
    mkdir happ-template
    tar -zxvf happ-template.tar.gz --strip-components=1 -C ./happ-template
    rm happ-template.tar.gz
    cd happ-template
    cp ui_src/.env.example ui_src/.env
    yarn hc:install
    yarn start
  '';
in
{
 buildInputs = [ script ];
}
