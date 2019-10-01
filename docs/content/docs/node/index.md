---
title: 'Node'
date: 2019-02-11T19:27:37+10:00
weight: 11
---

@todo https://forum.holochain.org/t/im-spinning-up-some-docs-for-holonix-feedback-welcome/451/12?u=thedavidmeister

## npm binaries

There is a conflict with the `PATH` handling of `npm`.

When binaries are added to `./node_modules/.bin` the default behaviour of `npm run` is to symlink them somewhere on the `PATH` outside the current repository.

Other tools that work with `npm` managed binaries such as `npx` do something similar.

This is incompatible with holonix for two reasons:

- `npm run` and `npx` can attempt to create symlinks in `/nix/store/...` which is read-only by design because nix derivations are hashed and immutable (like holochain zomes)
- `npm install` creates symlinks which are [not compatible with VirtualBox on Windows 10 without additional configuration per machine](https://superuser.com/questions/1115329/vagrant-shared-folder-and-symbolic-links-under-windows-10)

A simple workaround is to "wrap" node binaries in a [nixified bash script](/docs/bash) and pass cli arguments verbatim.

For example, the [ghost blogging platform](https://ghost.org/) normally expects to be installed globally with `npm install -g ghost` but can be wrapped locally in a nix shell.

`ghost/default.nix`

```nix
{ pkgs }:
let
  bin-name = "ghost";
  wrapper =  pkgs.writeShellScriptBin bin-name ''
   set -euo pipefail
   ./node_modules/.bin/${bin-name} "$@"
   '';
in
{
 buildInputs = [
  script
 ];
}
```

This pattern might be formalised in holonix itself sometime: https://github.com/holochain/holonix/issues/51
