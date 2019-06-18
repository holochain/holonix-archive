{ pkgs }:
{
 buildInputs =
 [
   pkgs.callPackage ./test { }
 ];
}
