#!/usr/bin/env bats

setup() {
  BATS_TMPDIR="$(mktemp -d)"
}

teardown() {
  rm -rf "${BATS_TMPDIR:?}"
}

@test "hApp scaffolding with hn-init" {
  cd "${BATS_TMPDIR:?}"
  hn-init
  cd my-app
  cat <<'EOF' > default.nix
let
  holonixRev = "main";

  holonixPath = builtins.fetchTarball "https://github.com/holochain/holonix/archive/${holonixRev}.tar.gz";
  holonix = import (holonixPath) {
    holochainVersionId = "v0_0_120";
  };
  nixpkgs = holonix.pkgs;
in nixpkgs.mkShell {
  inputsFrom = [ holonix.main ];
  packages = with nixpkgs; [
    # Additional packages go here
    nodejs-16_x
  ];
}
EOF

  nix-shell --pure --run '
      npm i
      npm run test
      npm run package
  '
}
