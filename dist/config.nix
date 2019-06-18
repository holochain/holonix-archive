{ pkgs, rust }:
{

 path = "dist";

 version = "0.0.19-alpha1";

 normalize-artifact-target = target:
  builtins.replaceStrings
    [ "unknown" ]
    [ "generic" ]
    target
 ;

 artifact-target = normalize-artifact-target ( if pkgs.stdenv.isDarwin then rust.generic-mac-target else rust.generic-linux-target );

}
