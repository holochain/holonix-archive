let
  # nixos channel latest 20.09
  # keep the Dockerfile in sync with this!
  nixpkgs = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/3a02dc9edb283beb9580c9329f242ad705a721c3.tar.gz";
    sha256 = "1d1lqjqqqskfg5b0hyy9q94yqzgwsnb5i0pcl71q378hl8wbgj6x";
  };

  # the mozilla rust overlay
  # allows us to track cargo nightlies in a nixos friendly way
  # avoids rustup
  # not compatible with parallel rustup installation
  nixpkgs-mozilla = fetchTarball {
    url = "https://github.com/mozilla/nixpkgs-mozilla/archive/8c007b60731c07dd7a052cce508de3bb1ae849b4.tar.gz";
    sha256 = "1zybp62zz0h077zm2zmqs2wcg3whg6jqaah9hcl1gv4x8af4zhs6";
  };
in

import nixpkgs {
  overlays = [ (import nixpkgs-mozilla) ];
}
