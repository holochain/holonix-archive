{ pkgs }:
{
 buildInputs =
 [
  # curl needed to push to codecov
  pkgs.curl
 ]
 ++ (pkgs.callPackage ./codecov { }).buildInputs
 ++ (pkgs.callPackage ./coverage { }).buildInputs
 ++ (pkgs.callPackage ./install { }).buildInputs
 ;
}
