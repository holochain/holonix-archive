{ pkgs }:
{
 buildInputs =
 [
   pkgs.callPackage ./compile { }
   pkgs.callPackage ./install { }
   pkgs.callPackage ./test { }
   pkgs.callPackage ./uninstall { }
 ];
}
