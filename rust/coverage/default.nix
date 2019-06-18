{ pkgs }:
{
 buildInputs =
 [
   # curl needed to push to codecov
   pkgs.curl

   (pkgs.callPackage ./codecov { })
   (pkgs.callPackage ./coverage { })
   (pkgs.callPackage ./install { })
 ]
 ;
}
