{ pkgs }:

let
  extraSubstitutors = [
    "https://cache.holo.host"
  ];
  trustedPublicKeys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "cache.holo.host-1:lNXIXtJgS9Iuw4Cu6X0HINLu9sTfcjEntnrgwMQIMcE="
    "cache.holo.host-2:ZJCkX3AUYZ8soxTLfTb60g+F3MkWD7hkH9y8CgqwhDQ="
  ];
in pkgs.writeScriptBin "holonix" ''
  export GC_ROOT_DIR="''${HOME:-/tmp}/.holonix"
  export SHELL_DRV="''${GC_ROOT_DIR}/shellDrv"
  export LOG="''${GC_ROOT_DIR}/log"

  cat <<- EOF
  # Holonix

  ## Permissions
  This scripts uses sudo to allow specifying Holo's Nix binary cache. Specifically:
  * Instruct Nix to use the following extra substitutors (binary cache):
    - ${builtins.concatStringsSep "\n- " extraSubstitutors}
  * Instruct Nix to use trust these public keys:
    - ${builtins.concatStringsSep "\n  - " trustedPublicKeys}

  ## Caching
  Holonix will be cached locally.
  To wipe the cache, remove all symlinks inside ''${GC_ROOT_DIR} and run "nix-collect-garbage".

  ## Running the cached version directly
  Use: nix-shell ''${SHELL_DRV}

  Building...
  EOF

  set -eou pipefail
  mkdir -p "''${GC_ROOT_DIR}"
  (
  exec 2>&1
  nix-instantiate --no-build-output --quiet --add-root "''${SHELL_DRV}" --indirect ${builtins.toString ./.} -A main
  nix-store \
      --add-root "''${SHELL_DRV}/refquery" --indirect \
      --query --references "''${SHELL_DRV}" > "''${GC_ROOT_DIR}/log" | \
      xargs sudo -E nix-store --realise \
      --option extra-substituters "${builtins.concatStringsSep " " extraSubstitutors}" \
      --option trusted-public-keys  "${builtins.concatStringsSep " " trustedPublicKeys}" \
      --add-root "''${GC_ROOT_DIR}/allrefs" --indirect
  )  >> "''${LOG}" || {
  rc=$?
  echo WARNING: Errors during build. Please see "''${LOG}" for details.
  if test -e "''${SHELL_DRV}"; then
      echo Falling back to cached version
  else
      exit $rc
  fi
  }
  echo -n Ready!
  export NIX_BUILD_SHELL=${pkgs.bashInteractive}/bin/bash
  nix-shell \
  --add-root "''${GC_ROOT_DIR}/shell" \
  "''${SHELL_DRV}" ''${@}
''
