let
  install = import ./src/install.nix;
  uninstall = import ./src/uninstall.nix;
in
[
  install
  uninstall
]
