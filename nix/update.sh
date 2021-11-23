#! /usr/bin/env nix-shell
#! nix-shell -p niv -i bash
niv update

nix/regen_versions.sh

cat << EOF | git commit VERSIONS.md nix/sources.* -F -
update nix sources

see VERSIONS.md for the exact changes
EOF
