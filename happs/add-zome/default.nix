{ pkgs }:
let
  name = "hc-happ-add-zome";

  script = pkgs.writeShellScriptBin name
  ''
    curl -L -o happ-template.tar.gz https://github.com/holochain/react-graphql-template/archive/master.tar.gz
    mkdir zome-template
    tar -zxvf zome-template.tar.gz --strip-components=1 -C ./zome-template
    rm zome-template.tar.gz
    cd zome-template/dna_src

    cp -R ./test/notes ./test/"''${1:-"my-new-zome"}"s
    cp -R ./zomes/notes ./zomes/"''${1:-"my-new-zome"}"s
    node replace.js ''${1:-"my-new-zome"}
    cd ../..
    cp -R ./zome-template/dna_src/test/"$1"s ./dna_src/test/"''${1:-"my-new-zome"}"s
    cp -R ./zome-template/dna_src/zomes/"$1"s ./dna_src/zomes/"''${1:-"my-new-zome"}"s
    rm -rf zome-template
  '';
in
{
 buildInputs = [ script ];
}
