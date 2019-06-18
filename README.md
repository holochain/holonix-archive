# Holonix

Base Holochain development environment & tooling.

NixOS derivation based.
Usable in every nix compatible environment.

Linux & Mac OS X run `nix-shell` natively.
Get it from `https://nixos.org/nix/download.html`.

Windows et. al. can use docker or vagrant to get a nix VM.

- docker hub coords: `holochain/holochain-rust`
- vagrant box url: `https://holochain.love/box`

See the `holochain-rust` repository for docker/vagrant examples.

## Scope

Holonix provides an extensible and standard dev environment for:

- Installing dependencies
- Running tests
- Building wasm
- Building binaries
- Implementing CI scripts
- Conductor management
- Installing situational tooling (e.g. `cargo-edit` for versioning)
- Release management, automation and deploying official binaries
- BAU automation and reporting tasks
- Downloading prebuilt official binaries from github
- Managing and updating binaries across official releases

### Why nix?

Nix approach offers unique benefits:

- Dependencies are injected into a single shell session only
  - Minimal modifications to the host environment
  - No need to maintain/rerun/troubleshoot installation scripts
  - Further isolation from host environment can be achieved with `nix-shell --pure`
- Dependencies are hashed
  - "Dependency hell" is avoided
  - Nice parallels with Holochain's hashed zomes model
  - Security + reliability benefits
- Dependencies can be garbage collected with the `nix-collect-garbage` command
- Single "package manager" across most operating systems
- Ability to ship utility scripts in the `shell.nix` file
- Access to the nix functional programming language for dependencies/script management
  - Allows for a structured approach to coding the ops infrastructure
  - Makes modern programming paradigm such as immutability, scopes, data structures, etc. in the ops tooling as opposed limitations and lack of expressivity of Bash/Makefile/etc.
- NixOS runs on HoloPorts so `nix-shell` provides similar behaviour/environment
  - Everything is pinned to the same nix channel and commit

And other benefits:

- Active and helpful community of contributors
  - IRC at #nixos
  - wiki at https://nixos.wiki/
- Ability to bundle scripts into convenient binaries for daily tasks
- Nice CLI interface with many flexible, well documented configuration options
- Available in shebang form as `#! /usr/bin/env nix-shell`
  - http://iam.travishartwell.net/2015/06/17/nix-shell-shebang/

## Contributing

The structure of our nix derivations is designed to be as modular as possible.

The folder structure is something like:

```
holonix
 |_app-spec
 |  |_test
 |  | |_default.nix
 |  |_...
 |  |_default.nix
 |_nixpkgs
 | |_nixpkgs.nix
 |_node
 | |_flush
 | | |_default.nix
 | |_default.nix
 |_...
default.nix
```

The `default.nix` file is used by `nix-shell` automatically.
This consumes `holonix/**` and provides several new derivations.

- `main`: used to construct the development environment in the nix shell
- `holochain.hc`: used to install latest `hc` binary with `nix-env`
- `holochain.holochain`: used to install latest `holochain` binary with `nix-env`

e.g. install binaries globally with:

```shell
nix-env -f https://holochain.love -iA holochain.hc holochain.holochain
```

## Contributions and extension

Holonix is designed to be used as a base layer and extended in other repos.

See `holochain-rust` for examples.

There are a few basic conventions to follow:

- Nest folders according to theme/tech/specificity
  - e.g. conductor management for conductor `x` sits under `conductor/x/**`
- All configuration strings and other primitives sit in a local `config.nix`
  - this is not a function it should be a constant set
  - use it with `import ./config.nix` and merge with returned vals
- Structure configuration as nested `foo.bar` rather than `foo-bar`
- All used and generated inputs to build the nix derivations sit in a local `default.nix`
  - `default.nix` files should "bubble up" to the root one level at a time
    - e.g. `default.nix` imports `conductor/default.nix` imports `conductor/node/default.nix`
  - root `default.nix` should only aggregate one level deeper derivations
  - use the nix convention pointing to the folder for `callPackage` and `import`
- Scripts for `foo` binaries sit in named `default.nix` files under `thing/foo/default.nix`
  - There is standard boilerplate for this, see an existing file for examples
  - Use `pkgs.writeShellScriptBin` by default
  - derived nix CLI commands are named following the path
    - e.g. `holonix/foo/bar/baz/default.nix` becomes `hn-foo-bar-baz`
- Put functions for builds in `lib.nix` files
  - e.g. `holonix/dist/lib.nix`
- Try not to stutter file names or commands
- Use `x/y/z/install/default.nix` for scripts that install things outside of what nix manages
  - Try to minimise use of additional install scripts, nix should handle as
    much as possible.
  - e.g. cargo installs things to the user's home directory
