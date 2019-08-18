{ pkgs }:
{
 buildInputs =
 [
  pkgs.hugo
  pkgs.asciinema

  (pkgs.writeShellScriptBin "hn-docs" ''
(cd docs && hugo serve )
  '')
 ]
 ++ (pkgs.callPackage ./github-pages { pkgs = pkgs; }).buildInputs
 ;
}
