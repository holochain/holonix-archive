{ pkgs, release }:
{
 buildInputs = []
 ++ (pkgs.callPackage ./changelog {
  release = release;
 }).buildInputs
 ;
}
