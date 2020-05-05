{
 pkgs,
 aws,
 darwin,
 dist,
 docs,
 git,
 linux,
 n3h,
 newrelic,
 node,
 openssl,
 release,
 rust,
 test,
 happs
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
 RUSTUP_TOOLCHAIN = rust.channel.version;
 CARGO_INCREMENTAL = rust.compile.incremental;
 RUST_LOG = rust.log;
 NUM_JOBS = rust.compile.jobs;
 RUST_BACKTRACE = rust.backtrace;

 RELEASE_VERSION = release.config.release.version.current;
 RELEASE_TAG = release.config.release.tag;

 OPENSSL_STATIC = openssl.static;

 # needed so bindgen can find libclang.so
 LIBCLANG_PATH="${pkgs.llvmPackages.libclang}/lib";

 # needed for newrelic to compile its dependencies
 # this is a hack to workaround this:
 # https://github.com/NixOS/nixpkgs/issues/18995
 hardeningDisable = [ "fortify" ];

 shellHook = ''
 # cargo should install binaries into this repo rather than globally
 # https://github.com/rust-lang/rustup.rs/issues/994
 #
 # cargo should NOT install binaries into this repo in vagrant as this breaks
 # under windows with virtualbox shared folders

 if [[ -z $NIX_ENV_PREFIX ]]
 then
  if [[ $( whoami ) == "vagrant" ]]
   then export NIX_ENV_PREFIX=/home/vagrant
   else export NIX_ENV_PREFIX=`pwd`
  fi
 fi

 # stable rust doesn't support all the debugging flags we are using
 if [[ $( rustc --version ) == *nightly* ]]
 then
  export RUSTFLAGS="${rust.compile.flags}"
 else
  export RUSTFLAGS="${rust.compile.stable-flags}"
 fi

 export CARGO_HOME="$NIX_ENV_PREFIX/.cargo"
 export CARGO_INSTALL_ROOT="$NIX_ENV_PREFIX/.cargo"
 export HC_TARGET_PREFIX=$NIX_ENV_PREFIX
 export CARGO_TARGET_DIR="$HC_TARGET_PREFIX/target"
 export CARGO_CACHE_RUSTC_INFO=1
 export PATH="$CARGO_INSTALL_ROOT/bin:$PATH"
 export NIX_LDFLAGS="${darwin.ld-flags}$NIX_LDFLAGS"
 export NIX_BUILD_SHELL=${pkgs.bashInteractive}/bin/bash

 # https://github.com/holochain/holonix/issues/12
 export TMP=$( mktemp -p /tmp -d )
 export TMPDIR=$TMP
 '';

 buildInputs = [
  # for mktemp
  pkgs.coreutils

  # simple dev feedback loop
  pkgs.unixtools.watch

  #flame graph dep
  pkgs.flamegraph
 ]
 ++ (pkgs.callPackage ./flush { }).buildInputs
 ++ aws.buildInputs
 ++ darwin.buildInputs
 ++ dist.buildInputs
 ++ docs.buildInputs
 ++ git.buildInputs
 ++ linux.buildInputs
 ++ n3h.buildInputs
 ++ newrelic.buildInputs
 ++ node.buildInputs
 ++ openssl.buildInputs
 ++ release.buildInputs
 ++ rust.buildInputs
 ++ test.buildInputs
 ++ happs.buildInputs
 ;
}
