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
    url = "https://github.com/mozilla/nixpkgs-mozilla/tarball/200cf0640fd8fdff0e1a342db98c9e31e6f13cd7";
    sha256 = "1am353ims43ylvay263alchzy3y87r1khnwr0x2fp35qr347bvxi";
  };
in

import nixpkgs {
  overlays = [ (import nixpkgs-mozilla) ];
}
