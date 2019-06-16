let
  install = import ./src/install.nix;
  test = import ./src/test.nix;
  uninstall = import ./src/uninstall.nix;
in
[
  install
  test
  uninstall
]
