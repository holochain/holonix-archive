{ pkgs }:
{
 buildInputs =
 [
   # wabt needs cmake
   pkgs.cmake
   pkgs.binaryen
   pkgs.wasm-gc
 ]
 ++ (pkgs.callPackage ./compile { }).buildInputs
 ;
}
