{ pkgs }:
{
 buildInputs =
 [
   pkgs.callPackage ./install { }
   pkgs.callPackage ./test { }
 ];
}
