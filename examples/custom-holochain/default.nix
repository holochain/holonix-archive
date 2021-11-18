let
  holonixPath = builtins.fetchTarball "https://github.com/holochain/holonix/archive/f3ecb117bdd876b8dcb33ad04984c5da5b2d358c.tar.gz";
  holonix = import (holonixPath) {
    holochainVersionId = "custom";
    holochainVersion = import ./holochain_version.nix;
  };
  nixpkgs = holonix.pkgs;
in nixpkgs.mkShell {
  inputsFrom = [ holonix.shell ];
  packages = [
    # additional packages go here
  ];
}
