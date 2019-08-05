{ pkgs }:
{
 buildInputs =
 [
  pkgs.hugo
  pkgs.mkdocs
 ]
 ++ (pkgs.callPackage ./github-pages { pkgs = pkgs; }).buildInputs
 ;
}
