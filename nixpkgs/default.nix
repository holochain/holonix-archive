let
  # nixos channel latest 19.09
  # keep the Dockerfile in sync with this!
  holo-nixpkgs = fetchTarball {
    url = "https://github.com/Holo-Host/holo-nixpkgs/archive/7db5779fce5d3a14585ed691b17ffac199c72990.tar.gz";
    sha256 = "1hanvqp1j0ql01cd0arz3f07nli7a2q2f0p3qdy7w9zr1610zqvk";
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

import holo-nixpkgs {
  overlays = [ (import nixpkgs-mozilla) ];
}
