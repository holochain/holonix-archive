#! /usr/bin/env nix-shell
#! nix-shell --pure --keep NIX_PATH
#! nix-shell -p cacert -p nixUnstable -p git
#! nix-shell -p niv -i bash
set -e
niv update ${@}

nix/regen_versions.sh

cat << EOF | git commit VERSIONS.md nix/sources.* -F -
update nix sources

see VERSIONS.md for the exact changes
EOF
