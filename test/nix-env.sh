#! /usr/bin/env nix-shell
#! nix-shell -i "bats -t" -p bats -p coreutils

@test "holochain conductor install" {

 echo '# holochain should not be installed at first' >&3
 ! [ -x "$(command -v holochain)" ]
 ! [ -x "$(command -v hc)" ]

 echo '# install holochain without hc' >&3

 nix-env -f . -iA holochain.holochain

 echo '# holochain should be installed now' >&3
 [ -x "$(command -v holochain)" ]
 ! [ -x "$(command -v hc)" ]

 echo '# uninstall holochain' >&3
 nix-env -e holochain

 echo '# holochain should not be installed now' >&3
 ! [ -x "$(command -v holochain)" ]
 ! [ -x "$(command -v hc)" ]

}

@test "hc cli install" {
 # https://github.com/holochain/holonix/issues/12
 export TMP=$( mktemp -p /tmp -d )
 export TMPDIR=$TMP
 export deps=('holochain' 'npm' 'cargo')
 export app_name=my_first_app
 export zome_name=my_zome

 echo '# hc should not be installed at first' >&3
 ! [ -x "$(command -v hc)" ]

 echo '# hc deps should not be globally visible' >&3
 for i in ${!deps[@]}
 do
  echo "# check ${deps[$i]} not exists" >&3
  ! [ -x "$(command -v ${deps[$i]})" ]
 done

 echo '# install hc without explicitly installing holochain' >&3
 nix-env -f . -iA holochain.hc

 echo '# hc should be installed now' >&3
 [ -x "$(command -v hc)" ]

 echo '# hc deps should not be globally visible' >&3
 for i in ${!deps[@]}
 do
  echo "# check ${deps[$i]} not exists" >&3
  ! [ -x "$(command -v ${deps[$i]})" ]
 done

 echo '# steps adapted from quickstart 2019-09-11' >&3

 echo '# hc init "$TMP/$app_name"' >&3
 hc init "$TMP/$app_name"

 echo '# cd "$TMP/$app_name"' >&3
 cd "$TMP/$app_name"

 echo '# hc generate "zomes/$zome_name"' >&3
 hc generate "zomes/$zome_name"

 echo '# hc test' >&3
 hc test

 echo '# teardown' >&3
 nix-env -e hc

 echo '# hc should not be installed now' >&3
 ! [ -x "$(command -v hc)" ]

 echo '# hc deps should not be globally visible' >&3
 for i in ${!deps[@]}
 do
  echo "# check ${deps[$i]} not exists" >&3
  ! [ -x "$(command -v ${deps[$i]})" ]
 done
}
