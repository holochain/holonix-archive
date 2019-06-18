{ pkgs }:
{
 buildInputs = []
 ++ (pkgs.callPackage ./test { }).buildInputs
 ++ (pkgs.callPackage ./test_proc_macro { }).buildInputs
 ;
}
