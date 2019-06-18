{ pkgs }:
{
 buildInputs = []
 ++ (pkgs.callPackage ./install { }).buildInputs
 ++ (pkgs.callPackage ./uninstall { }).buildInputs
 ;
}
