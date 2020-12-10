{ pkgs }:
{
 buildInputs =
 [
   # wabt needs cmake
   pkgs.cmake
   pkgs.binaryen
  # missing
  #  pkgs.wasm-gc
   pkgs.wabt
 ]
 ;
}
