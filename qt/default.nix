{ pkgs }:
{
 buildInputs =
 [
  pkgs.qt59.qmake
 ]
 ++ (pkgs.callPackage ./c-bindings { }).buildInputs
 ;
}
