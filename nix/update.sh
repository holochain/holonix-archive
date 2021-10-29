#! /usr/bin/env nix-shell 
#! nix-shell -p niv -i bash
niv update

cat << EOF > VERSIONS.md
## holochain binary versions
the following versions are available via their respective holochainVersionId.

### main
$(nix-shell --pure --argstr holochainVersionId main --run 'hn-introspect hc')

### develop
$(nix-shell --pure --argstr holochainVersionId develop --run 'hn-introspect hc')

## common binaries
as well as the following common commands of interest:

$(nix-shell --pure --argstr holochainVersionId develop --run 'hn-introspect common')
EOF

cat << EOF | git commit VERSIONS.md nix/sources.* -F -
update holochain-nixpkgs

see VERSIONS.md for details
EOF
