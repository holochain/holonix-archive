{ pkgs }:
{
 buildInputs =
 [
  pkgs.git
  pkgs.gitAndTools.git-hub
  # need the haskellPackages version for darwin support
  pkgs.haskellPackages.github-release
 ]
 ;
}
