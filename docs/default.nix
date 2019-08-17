{ pkgs }:
{
 buildInputs =
 [
  pkgs.hugo

  (pkgs.writeShellScriptBin "hn-docs" ''
(cd docs && hugo serve )
  '')
 ]
 ++ (pkgs.callPackage ./github-pages { pkgs = pkgs; }).buildInputs
 ;
}
