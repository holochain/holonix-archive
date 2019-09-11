{ pkgs }:
let
 node = pkgs.nodejs-11_x;
 clang = pkgs.clang;

 npm-wrapper = pkgs.runCommand "npm" { nativeBuildInputs = [ pkgs.makeWrapper ]; } ''
   makeWrapper ${node}/bin/npm $out/bin/npm \
     --set CXX ${clang}/bin/clang++
 '';
in
{
 buildInputs =
 [
   # node and yarn version used in:
   # - binary building
   # - app spec tests
   # - deploy scripts
   # - node conductor management
   node
   clang
   npm-wrapper
   pkgs.yarn

   # needed by node-gyp
   pkgs.python
 ]
 ++ (pkgs.callPackage ./flush { }).buildInputs
 ;
}
