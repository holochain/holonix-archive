{ pkgs }:
{
 buildInputs =
 [
   # node and yarn version used in:
   # - binary building
   # - app spec tests
   # - deploy scripts
   # - node conductor management
   pkgs.nodejs-11_x
   pkgs.yarn

   # needed for building node_modules on mac
   pkgs.clang

   # needed by node-gyp
   pkgs.python
 ]
 ++ (pkgs.callPackage ./flush { }).buildInputs
 ;
}
