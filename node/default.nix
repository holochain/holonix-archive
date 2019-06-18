{ pkgs }:
{
 buildInputs =
 [
   # node and yarn version used in:
   # - binary building
   # - app spec tests
   # - deploy scripts
   # - node conductor management
   pkgs.nodejs-8_x
   pkgs.yarn

   # needed by node-gyp
   pkgs.python
 ]
 ++ (pkgs.callPackage ./flush { }).buildInputs
 ;
}
