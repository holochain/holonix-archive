{ pkgs }:
let
  install = pkgs.callPackage ./install { };
  test = pkgs.callPackage ./test { };
  uninstall = pkgs.callPackage ./uninstall { };
in
{
 buildInputs =
 [
   install
   test
   uninstall
 ];
}
