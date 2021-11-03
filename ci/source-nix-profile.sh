#!/bin/sh
for p in $HOME/.nix-profile/etc/profile.d/nix.sh /nix/var/nix/profiles/default/etc/profile.d/nix.sh /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh; do
  if test -f  $p; then
    . $p
  fi
done
