{ pkgs }:
let
  compile = pkgs.callPackage ./nix/compile.nix { };
in
{
 buildInputs =
 [
   # wabt needs cmake
   pkgs.cmake
   compile
 ]
 ;
}
