{
 pkgs,
 dist,
 rust,
 holochain,
 lib,
}:
let
  name = "hn-dist-audit";

  script = pkgs.writeShellScriptBin name
  ''
  echo
  echo "All the important dist vars:"
  echo

  echo "Binary version is ${dist.version}"

  echo
  echo "All the prefetching:"
  echo

  echo "Darwin holochain hash is currently ${holochain.sha256.darwin}"
  echo "Darwin holochain prefetch:"
  nix-prefetch-url ${lib.artifact-url { name = holochain.name; target = ( lib.normalize-artifact-target rust.generic-mac-target ); }}
  echo

  echo "Linux holochain hash is currently ${holochain.sha256.linux}"
  echo "Linux holochain prefetch:"
  nix-prefetch-url ${lib.artifact-url { name = holochain.name; target = ( lib.normalize-artifact-target rust.generic-linux-target ); }}
  echo
  '';
in
{
 buildInputs = [ script ];
}
