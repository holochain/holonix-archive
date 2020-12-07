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
    url = "https://github.com/mozilla/nixpkgs-mozilla/archive/d46240e8755d91bc36c0c38621af72bf5c489e13.tar.gz";
    sha256 = "0icws1cbdscic8s8lx292chvh3fkkbjp571j89lmmha7vl2n71jg";
  };
in

import nixpkgs {
  overlays = [ (import nixpkgs-mozilla) ];
}
