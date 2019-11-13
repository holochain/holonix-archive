{ pkgs, lib, node, rust, holochain, git }:
let
 config = import ./config.nix;
 derivation = (lib.binary-derivation (config // {
  # hc needs holochain, node, cargo and git to function
  # we want to reuse all the buildInputs for each of these namespaces from the
  # nix-shell to keep everything consistent in the nix-env wrappers
  deps = [ pkgs.zlib ]
  ++ holochain.buildInputs
  ++ node.buildInputs
  ++ rust.buildInputs
  ++ git.buildInputs;
 }));
in
config // {
 buildInputs =
 [
 derivation
 ];
 derivation = derivation;
}
