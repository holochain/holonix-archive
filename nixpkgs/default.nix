let
  # nixos channel latest 19.09
  # keep the Dockerfile in sync with this!
  nixpkgs = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs-channels/archive/nixos-19.09.tar.gz";
    sha256 = "15fwszhn6078sbrb8qk83g8afvh4qnmvff0qbkbvq3cm1fxni2w1";
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
