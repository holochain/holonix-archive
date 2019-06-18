{ pkgs }:
{
 buildInputs =
 [
   pkgs.callPackage ./install { }
   pkgs.callPackage ./uninstall { }
 ]
 ;
}
