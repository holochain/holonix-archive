{ pkgs }:
{
 buildInputs = []
 ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
  pkgs.linuxPackages.perf
 ];
}
