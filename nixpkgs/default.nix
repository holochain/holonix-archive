let
  # nixos channel latest 19.03 2019-06-26
  # keep the Dockerfile in sync with this!
  nixpkgs = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/tarball/8634c3b619909db7fc747faf8c03592986626e21";
    sha256 = "0hcpy4q64vbqmlmnfcavfxilyygyzpwdsss8g3p73ikpic0j6ziq";
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
