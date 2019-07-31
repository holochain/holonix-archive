{ pkgs }:
{
 buildInputs =
 [
  pkgs.hugo
 ]
 ++ (pkgs.callPackage ./github-pages { pkgs = pkgs; }).buildInputs
 ;
}
