{ pkgs }:
let
 node = pkgs.nodejs-12_x;
 clang = pkgs.clang;
in
{
 clang = clang;
 buildInputs =
 [
   # node and yarn version used in:
   # - binary building
   # - app spec tests
   # - deploy scripts
   # - node conductor management
   node
   clang
   pkgs.yarn
 ]
 ++ (pkgs.callPackage ./scaffold { }).buildInputs
 ++ (pkgs.callPackage ./create { }).buildInputs
 ++ (pkgs.callPackage ./add-zome { }).buildInputs
 ;
}
