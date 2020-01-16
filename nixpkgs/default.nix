let
  # keep the Dockerfile in sync with this!
  holo-nixpkgs = fetchTarball {
    url = "https://github.com/Holo-Host/holo-nixpkgs/archive/7a3e5013e193434f4becd8ffd909d46128055a92.tar.gz";
    sha256 = "0iw6fdlkk3ffwm4vnry61j58czlwyza75hdap34kvnsq4wqbr3sf";
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
