#! /usr/bin/env nix-shell
#! nix-shell -i "bats -t" -p bats -p coreutils

setup () {
 nix-env -e holochain hc
}

teardown () {
 nix-env -e holochain hc
}

@test "holochain trycp_server install" {

 echo '# trycp_server should not be instaled at first' >&3
 ! [ -x "$( command -v trycp_server )" ]

 echo '# install trycp_server' >&3

 nix-env -f . -iA holochain.trycp_server

 echo '# trycp_server should be installed now' >&3
 [ -x "$( command -v trycp_server )" ]

 version="$( trycp_server -V )"
 echo "# smoke test trycp_server version result: $version" >&3
 [[ "$version" == "trycp_server 0.0."* ]]

 echo '# uninstall trycp_server' >&3
 nix-env -e trycp_server

 echo '# trycp_server should not be installed now' >&3
 ! [ -x "$( command -v trycp_server )" ]
}

@test "holochain sim2h_server install" {

 echo '# sim2h_server should not be instaled at first' >&3
 ! [ -x "$( command -v sim2h_server )" ]

 echo '# install sim2h_server' >&3

 nix-env -f . -iA holochain.sim2h_server

 echo '# sim2h_server should be installed now' >&3
 [ -x "$( command -v sim2h_server )" ]

 version="$( sim2h_server -V 2>/dev/null )"
 echo "# smoke test sim2h_server version result: $version" >&3
 [[ "$version" == "sim2h-server 0.0."* ]]

 echo '# uninstall sim2h_server' >&3
 nix-env -e sim2h_server

 echo '# sim2h_server should not be installed now' >&3
 ! [ -x "$( command -v sim2h_server )" ]
}

@test "holochain conductor install" {

 echo '# holochain should not be installed at first' >&3
 ! [ -x "$( command -v holochain )" ]
 ! [ -x "$( command -v hc )" ]

 echo '# install holochain without hc' >&3

 nix-env -f . -iA holochain.holochain

 echo '# holochain should be installed now' >&3
 [ -x "$( command -v holochain )" ]
 ! [ -x "$( command -v hc )" ]

 version="$( holochain -V )"
 echo "# smoke test holochain version result: $version" >&3
 [[ "$version" == "holochain 0.0."* ]]

 echo '# uninstall holochain' >&3
 nix-env -e holochain

 echo '# holochain should not be installed now' >&3
 ! [ -x "$( command -v holochain )" ]
 ! [ -x "$( command -v hc )" ]

}

@test "hc cli install" {
 # https://github.com/holochain/holonix/issues/12
 export TMP=$( mktemp -p /tmp -d )
 export TMPDIR=$TMP
 # this setting of $USER should not be needed once new docker is built
 export USER=$(id -u -n)
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

 version="$( hc -V )"
 echo "# smoke test holochain version result: $version" >&3
 [[ "$version" == "hc 0.0."* ]]

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
