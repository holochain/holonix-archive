let
  # nixos channel latest 19.09
  # keep the Dockerfile in sync with this!
  nixpkgs = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/821c7ed030bca86c8217e6d20df1f01c6474adf4.tar.gz";
    sha256 = "0varkgzi5nbx4kb6mjmllk1a48pc5nmad6jfikj627yqrb4wcyfw";
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
