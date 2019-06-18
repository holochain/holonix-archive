{ pkgs }:
{
 buildInputs =
 [
   (pkgs.callPackage ./nix/check.nix { })
   (pkgs.callPackage ./nix/fmt.nix { })
   (pkgs.callPackage ./nix/install.nix { })
 ]
 ;
}
