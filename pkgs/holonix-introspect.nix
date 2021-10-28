{ lib
, pkgs
, writeShellScriptBin
, holochainVersionId
, holochainBinaries
, pkgsOfInterest ? {}
, cmdsOfInterest ? [
    "rustc"
    "cargo fmt"
    "cargo clippy"
    "perf"
  ]
, gnugrep
}:

let
  namesVersionsStringPkgs = packages: lib.attrsets.mapAttrsToList (name: value:
    if !builtins.isAttrs value
    then ""
    else (
      "echo \- ${name}-" + (
        if builtins.hasAttr "version" value
        then "${value.version}"
        else "$(${name} --version | cut -d' ' -f2-)"
      ) + (
        if !builtins.hasAttr "src" value
        then ""
        else
          let
            url = builtins.toString (value.src.urls or value.src.url or "<not found>");
            delim = if lib.strings.hasInfix "github.com" url then "/tree/" else "#";
            rev = builtins.toString value.src.rev or "<not found>";
          in
            ": " + url + delim + rev
      )
    )
  ) packages;

  namesVersionsStringBins = cmds: builtins.map (bin:
    "echo \- ${bin}: $(${bin} --version)"
      # else "$(${name} --version | ${gawk}/bin/awk '{ print $2}')"
  ) cmds;

in
writeShellScriptBin "hn-introspect" ''
  function hcInfo() {
    echo holochainVersionId: ${holochainVersionId}
    ${builtins.concatStringsSep "\n" (namesVersionsStringPkgs holochainBinaries)}
  }

  function commonInfo() {
    ${builtins.concatStringsSep "\n" (namesVersionsStringPkgs pkgsOfInterest)}
    ${builtins.concatStringsSep "\n" (namesVersionsStringBins cmdsOfInterest)}
  }

  case "$1" in
    "hc")
      hcInfo
      ;;

    "common")
      commonInfo
      ;;

    *)
      echo List of applications and their version information
      echo
      hcInfo
      echo ""
      commonInfo
  esac
''
