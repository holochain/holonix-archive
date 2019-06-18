{ pkgs }:
{
 buildInputs = [
  pkgs.callPackage ./test { }
  pkgs.callPackage ./test_proc_macro { }
 ];
}
