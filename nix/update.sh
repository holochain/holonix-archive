#! /usr/bin/env nix-shell 
#! nix-shell -p niv -i bash
niv update

cat << EOF | git commit nix/sources.* -F -

update holochain-nixpkgs

---
the following versions are now available via their respective holochainVersionId:

$(nix-shell --pure --argstr holochainVersionId main --run 'hn-introspect hc')

$(nix-shell --pure --argstr holochainVersionId develop --run 'hn-introspect hc')

---
as well as the following common commands of interest:

$(nix-shell --pure --argstr holochainVersionId develop --run 'hn-introspect common')
EOF
