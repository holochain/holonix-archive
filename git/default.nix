{ pkgs }:
{
  buildInputs =
    [
      pkgs.git
      pkgs.gitAndTools.git-hub
      pkgs.cacert
      # need the haskellPackages version for darwin support
      # broken
      # pkgs.haskellPackages.github-release
    ];
}
