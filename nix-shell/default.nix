{
 pkgs,
 app-spec,
 app-spec-cluster,
 cli,
 conductor,
 darwin,
 dist,
 git,
 n3h,
 node,
 openssl,
 qt,
 rust,
}:
{
 name = "holonix-shell";

 # non-nixos OS can have a "dirty" setup with rustup installed for the current
 # user.
 # `nix-shell` can inherit this e.g. through sourcing `.bashrc`.
 # even `nix-shell --pure` will still source some files and inherit paths.
 # for those users we can at least give the OS a clue that we want our pinned
 # rust version through this environment variable.
 # https://github.com/rust-lang/rustup.rs#environment-variables
 # https://github.com/NixOS/nix/issues/903
 RUSTUP_TOOLCHAIN = rust.nightly.version;
 RUSTFLAGS = rust.compile.flags;
 CARGO_INCREMENTAL = rust.compile.incremental;
 RUST_LOG = rust.log;
 NUM_JOBS = rust.compile.jobs;

 OPENSSL_STATIC = openssl.static;

 shellHook = ''
 # cargo should install binaries into this repo rather than globally
 # https://github.com/rust-lang/rustup.rs/issues/994
 #
 # cargo should NOT install binaries into this repo in vagrant as this breaks
 # under windows with virtualbox shared folders
 if [[ $( whoami ) = "vagrant" ]]
  then export NIX_ENV_PREFIX=/home/vagrant
  else export NIX_ENV_PREFIX=`pwd`
 fi

 export CARGO_HOME="$NIX_ENV_PREFIX/.cargo"
 export CARGO_INSTALL_ROOT="$NIX_ENV_PREFIX/.cargo"
 export PATH="$CARGO_INSTALL_ROOT/bin:$PATH"
 export HC_TARGET_PREFIX=~/nix-holochain/
 export NIX_LDFLAGS="${darwin.ld-flags}$NIX_LDFLAGS"
 '';

 buildInputs =
 [
  (pkgs.callPackage ./flush { })
  (pkgs.callPackage ./test { })
 ]
 ++ app-spec.buildInputs
 ++ app-spec-cluster.buildInputs
 ++ cli.buildInputs
 ++ conductor.buildInputs
 ++ darwin.buildInputs
 ++ dist.buildInputs
 ++ git.buildInputs
 ++ n3h.buildInputs
 ++ node.buildInputs
 ++ openssl.buildInputs
 ++ qt.buildInputs
 ++ rust.buildInputs
 ;
}
