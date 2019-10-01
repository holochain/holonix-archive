---
title: 'IDE support'
date: 2019-02-11T19:27:37+10:00
weight: 17
---

@todo https://forum.holochain.org/t/im-spinning-up-some-docs-for-holonix-feedback-welcome/451/12?u=thedavidmeister

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

This gives us two viable options for pointing an IDE at relevant binaries:

- Run the IDE from _inside_ an active nix-shell session where the `$PATH` will be managed to include relevant binaries
- Configure the IDE to point directly at the nix store

The first option is simple and easy if it works for your IDE/plugin combination but likely won't work for everyone. It also adds mental overhead to the development workflow to keep track of various shell sessions.

The main benefit of the first option is that it will always be as "fresh" as your shell session. I.e. you will never have a versioning discrepency between the binaries used by the IDE and on the cli.

The second option provides more direct control and is more likely to be supported by the IDE.

If your IDE supports configuring the absolute path to a binary then drop into a nix shell and find it with `command`.

For example, to find the latest `cargo` binary from holonix master branch:

```shell
nix-shell https://holochain.love --run 'command -v cargo'
```

## Rust support

The bigges
