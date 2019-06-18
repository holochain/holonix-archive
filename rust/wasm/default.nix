{ pkgs }:
{
 buildInputs =
 [
   # wabt needs cmake
   pkgs.cmake
 ]
 ++ (pkgs.callPackage ./compile { }).buildInputs
 ;
}
