{ lib
, pkgs
, writeShellScriptBin
, holochainVersionId
, pkgsOfInterest
}:

let
  namesVersionsString = lib.attrsets.mapAttrsToList (name: value:
    if builtins.isAttrs value && builtins.hasAttr "src" value
    then "echo \- ${name}" + (if builtins.hasAttr "version" value then "-${value.version}" else "") + ": " + (builtins.toString value.src.urls)
    else ""
  ) pkgsOfInterest;

in
writeShellScriptBin "hn-introspect" ''
  echo holochainVersionId: ${holochainVersionId}
  echo List of holochain packages and their upstream information:
  ${builtins.concatStringsSep "\n" namesVersionsString}
''
