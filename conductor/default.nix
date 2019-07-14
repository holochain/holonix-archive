{ pkgs }:
{
 buildInputs = []
 ++ (pkgs.callPackage ./node { }).buildInputs
 ++ (pkgs.callPackage ./rust { }).buildInputs
 ;
}
