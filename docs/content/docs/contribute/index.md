---
title: 'Contribute'
date: 2019-02-11T19:27:37+10:00
weight: 20
---

@todo https://forum.holochain.org/t/im-spinning-up-some-docs-for-holonix-feedback-welcome/451/12?u=thedavidmeister

**below all pulled verbatim from old readme**

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
