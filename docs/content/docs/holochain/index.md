---
title: 'Holochain'
date: 2019-02-11T19:27:37+10:00
weight: 9
---

## Holochain rust components

There are three main artifacts provided by holochain.

- The rust conductor
- The holochain development kit (hdk)
- The command line scaffolding tool (cli)

The conductor and cli are distributed as [binaries on github](https://github.com/holochain/holochain-rust/releases).

The hdk is a rust crate used by zome developers directly to compile holochain compatible wasm.

All of these have shared upstream dependencies on holohain specific rust crates and cli has a dependency on conductor.

<div class="mermaid">
graph LR;
    lib3h --> conductor
    persistence --> conductor
    serialization --> conductor
    serialization --> persistence
    persistence --> lib3h
    serialization --> hdk
    persistence --> hdk
    conductor --> cli
    persistence --> cli
    serialization --> cli
    hdk --> zome-wasm
    style conductor fill:white,stroke:orange,stroke-width:3px
    style cli fill:white,stroke:orange,stroke-width:3px
    style hdk fill:white,stroke-width:3px
    style zome-wasm fill:palegreen
</div>

## Holochain rust versions

All of the holochain rust components use the same version of rust to compile.

The rust compiler is managed in holonix using [the Mozilla rust overlay](https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/rust.section.md#controlling-rust-version-inside-nix-shell).

This rust version changes periodically to track new nightly versions and/or include new tooling.

This is relevant to zome developers because the **hdk also tracks the version of rust in holonix used to compile the conductor and cli**.

Rust has two main version streams `nightly` and `stable`.

The `stable` stream is guaranteed to be API compatible with all other `stable` versions within the same major version but `nightly` is incompatible with itself on a daily basis.

It is _common_ that holochain crates compile one day and not the next if tracking `nightly` strictly.

For this reason the rust version is changed relatively infrequently, every few months or so.

A rust version is selected that supports both `fmt` and `clippy` for static code analysis and formatting beyond what the compiler supports by default.

The goal is that hdk will track rust `stable` at some point in the mid-term future. This will greatly stabilise the zome developer experience from the perspective of rust compilation. The binaries may continue to be compiled with `nightly` to take advantage of new compiler features but this would be decoupled from zome development.

## Holochain binaries

Both `conductor` and `cli` binaries are compiled on:

- MacOS X with the `x86_64-apple-darwin` rust target
- Windows MSVC with the `x86_64-pc-windows-msvc` rust target
- Windows GNU with the `x86_64-pc-windows-gnu` rust target
- Ubuntu with the `x86_64-unknown-linux-gnu` rust target

The dependencies installed to compile these binaries are **not using holonix**. They are simply dropped in manually by whatever package manager fits each platform, `choco`, `brew` or `apt-get`.

The linker is then updated to be `/nix/store` compatible with `patchelf`.

This is for historical reasons only, there is a short-mid term goal to [nixify all the release binary compilations](https://github.com/holochain/holonix/issues/52).

This is different to how HoloPortOS works, where the holochain `conductor` is compiled statically to `musl` entirely with a nix derivation.

Once binaries are deployed to github there is a new version of holonix released.

Every version of holonix includes the latest set of holochain binaries at the time of tagging the holonix release.

It is important for zome development to pin the zome repository to a version of holonix so that the conductor version matches the wasm code.

### Shell binaries

The standard way to access the binaries is to drop into a nix shell.

<script
 id="asciicast-264024"
 src="https://asciinema.org/a/264024.js"
 data-autoplay="true"
 data-theme="solarized-light"
 data-rows="20"
 async>
</script>

If this isn't working or the wrong version of a binary is being used see the [troubleshooting guide](/docs/support).

### Environment binaries

Nix has a tool called `nix-env` that works like a traditional package manager to install binaries globally.

The holochain binaries are available as `holochain.holochain` and `holochain.hc`.

To install them with `nix-env` run:

```bash
nix-env -f {{ path/url to holonix }} -iA holochain.holochain holochain.hc
```

Rerunning the same command will update the installed versions.

To uninstall with `nix-env` run:

```bash
nix-env -e holochain hc
```
