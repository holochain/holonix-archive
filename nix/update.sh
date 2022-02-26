#! /usr/bin/env nix-shell
#! nix-shell ../default.nix
#! nix-shell --pure
#! nix-shell -i bash

set -e
niv update ${@}

nix/regen_versions.sh

cat << EOF | git commit VERSIONS.md nix/sources.* -F -
update nix sources

see VERSIONS.md for the exact changes
EOF
