{
 pkgs,
 dist,
 rust,
 cli,
 conductor,
 sim2h_server,
 trycp_server,
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

  echo "Darwin CLI hash is currently ${cli.sha256.darwin}"
  echo "Darwin CLI prefetch:"
  nix-prefetch-url ${lib.artifact-url { name = cli.name; target = ( lib.normalize-artifact-target rust.generic-mac-target ); }}
  echo

  echo "Darwin conductor hash is currently ${conductor.sha256.darwin}"
  echo "Darwin conductor prefetch:"
  nix-prefetch-url ${lib.artifact-url { name = conductor.name; target = ( lib.normalize-artifact-target rust.generic-mac-target ); }}
  echo

  echo "Darwin sim2h_server hash is currently ${sim2h_server.sha256.darwin}"
  echo "Darwin sim2h_server prefetch:"
  nix-prefetch-url ${lib.artifact-url { name = sim2h_server.name; target = ( lib.normalize-artifact-target rust.generic-mac-target ); }}
  echo

  echo "Darwin trycp_server hash is currently ${trycp_server.sha256.darwin}"
  echo "Darwin trycp_server prefetch:"
  nix-prefetch-url ${lib.artifact-url { name = trycp_server.name; target = ( lib.normalize-artifact-target rust.generic-mac-target ); }}
  echo

  echo "Linux CLI hash is currently ${cli.sha256.linux}"
  echo "Linux CLI prefetch:"
  nix-prefetch-url ${lib.artifact-url { name = cli.name; target = ( lib.normalize-artifact-target rust.generic-linux-target ); }}
  echo

  echo "Linux conductor hash is currently ${conductor.sha256.linux}"
  echo "Linux conductor prefetch:"
  nix-prefetch-url ${lib.artifact-url { name = conductor.name; target = ( lib.normalize-artifact-target rust.generic-linux-target ); }}
  echo

  echo "Linux sim2h_server hash is currently ${sim2h_server.sha256.linux}"
  echo "Linux sim2h_server prefetch:"
  nix-prefetch-url ${lib.artifact-url { name = sim2h_server.name; target = ( lib.normalize-artifact-target rust.generic-linux-target ); }}
  echo

  echo "Linux trycp_server hash is currently ${trycp_server.sha256.linux}"
  echo "Linux trycp_server prefetch:"
  nix-prefetch-url ${lib.artifact-url { name = trycp_server.name; target = ( lib.normalize-artifact-target rust.generic-linux-target ); }}
  echo
  '';
in
{
 buildInputs = [ script ];
}
