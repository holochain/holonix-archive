{ pkgs }:
{
 buildInputs = []
 ++ (pkgs.callPackage ./check { }).buildInputs
 ++ (pkgs.callPackage ./fmt { }).buildInputs
 ++ (pkgs.callPackage ./install { }).buildInputs
 ;
}
