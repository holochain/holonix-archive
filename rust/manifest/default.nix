{ pkgs }:
{
 buildInputs =
 [
  (pkgs.callPackage ./install { })
  (pkgs.callPackage ./list-unpinned { })
  (pkgs.callPackage ./set-ver { })
  (pkgs.callPackage ./test-ver { })
 ]
 ;
}
