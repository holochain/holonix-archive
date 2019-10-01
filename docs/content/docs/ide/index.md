---
title: 'IDE support'
date: 2019-02-11T19:27:37+10:00
weight: 17
---

## Overview

Every IDE has different functionality, assumptions and audience.

Even ignoring nix we need to deal with interactions between languages, personal preferences and IDE plugin ecosystems.

An example highlighting this for a single language (Rust) can be seen at https://areweideyet.com/

The only difference between nix and not-nix for an IDE is how it discovers the underlying tooling.

We can't provide deep support for every IDE out there but we certainly want to shine a light on what people are doing to target popular setups.

A [survey was conducted on reddit in 2019](https://www.reddit.com/r/holochain/comments/cjme4a/whats_your_favorite_ide/) showing the most popular IDEs are Visual Studio, Intellij Rust and Atom.

## $PATH handling

As `nix-shell` is designed to quarantine the changes it makes to a single shell session, there is no way for an IDE to "see" what nix is doing outside of that.

Fortunately nix also hashes the result of everything it builds and locks it all as read only.

This gives us three viable options for pointing an IDE at relevant binaries:

- Run the IDE from _inside_ an active nix-shell session where the `$PATH` will be managed to include relevant binaries
- Configure the IDE to point directly at the nix store
- Create a dedicated IDE-specific plugin that is "nix aware"

### Active nix-shell

The first option is simple and easy if it works for your IDE/plugin combination but likely won't work for everyone. It also adds mental overhead to the development workflow to keep track of various shell sessions.

The main benefit of the first option is that it will always be as "fresh" as your shell session. I.e. you will never have a versioning discrepency between the binaries used by the IDE and on the cli.

### Absolute path configuration

The second option provides more direct control and is more likely to be supported by the IDE.

If your IDE supports configuring the absolute path to a binary then drop into a nix shell and find it with `command`.

For example, to find the latest `cargo` binary from holonix master branch:

```shell
nix-shell https://holochain.love --run 'command -v cargo'
```

The main benefit of the second option is that it persists across many nix shell sessions.

The main drawback is a direct consequence of this, the configuration will need to be handled manually moving forward. If a different version of a binary derivation is pulled into holonix (e.g. new Rust `nightly`) then the IDE will need to be reconfigured to match.

### Dedicated plugin

Depending on the IDE it may be possible to write (or find) a plugin for your language (e.g. Rust) that is "nix aware".

For example, there is a [Nix plugin for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=arrterian.nix-env-selector) that was [discussed in the Holonix github](https://github.com/holochain/holonix/pull/15#issuecomment-535672266).

The benefit of a dedicated plugin is the promise of deeply integrated support for many nix and language specfic features.

The main drawback is that Holonix has no control over how any plugin works and all support/maintenance is through third parties (or yourself).

## Rust support

The biggest hurdle for Rust support is the common assumption (by IDE plugin developers) that `rustup` is installed and used exclusively to manage `cargo`.

Nix shell supports installing `rustup` but doesn't support parallel management of `cargo` from both the Mozilla Rust overlays and `rustup`.

When `rustup` is installed it typically overrides the `cargo` version even inside the nix shell due to the default precedence of binaries on the `$PATH`.

Normally it isn't recommended to try and use `rustup` and `nix-shell` at the same time, or to at least carefully construct a `$PATH` that makes sense for your local workflow.

If an IDE plugin requires a `rustup` path then there isn't much that you can do other than use a different plugin or manually match the `nightly` dates.

If you can provide a `cargo` binary directly this is the preferred approach (see above).

### Visual Studio Code (Rust)

There is a [discussion around Visual Studio Code support](https://github.com/holochain/holonix/pull/15) for Rust in the Holonix Github repository.

The default configuration uses rustup but this must be disabled by setting `rust-client.disableRustup` in the Visual Studio Code configuration.

That discussion also [refers to a marketplace plugin](https://marketplace.visualstudio.com/items?itemName=arrterian.nix-env-selector) that directly integrates Nix with the IDE.
