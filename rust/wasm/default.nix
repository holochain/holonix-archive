{ pkgs }:
{
 buildInputs =
 [
   # wabt needs cmake
   pkgs.cmake
   pkgs.binaryen
   pkgs.wasm-gc
 ]
 ;
}
