# This is just a simple proxy to github:holochain/holochain/
args @ {...}:
let
  flake =
    import
    (
      let lock = builtins.fromJSON (builtins.readFile ./flake.lock); in
      fetchTarball {
        url = "https://github.com/edolstra/flake-compat/archive/${lock.nodes.flake-compat.locked.rev}.tar.gz";
        sha256 = lock.nodes.flake-compat.locked.narHash;
      }
    )
    { src = ./.; };
in
  import (flake.defaultNix.inputs.holochain + /holonix) args
