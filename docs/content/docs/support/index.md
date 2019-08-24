---
title: 'Support & debug'
date: 2019-02-11T19:27:37+10:00
weight: 19
---

## Holochain forum

The [forum](https://forum.holochain.org/) is the best place to seek help for all things holochain.

There is a [category dedicated to holonix discussion](https://forum.holochain.org/c/technical/holonix).

## NixOS chat

The NixOS community is active and helpful in IRC chat.

Join the `#nixos` channel on `freenode.net` IRC servers.

## Troubleshooting

### cruft on the PATH

Nix only manages the `PATH` that they are aware of, e.g. `/nix/store`.

Nix shell only adds things to the `PATH` by default.

If another tool adds binaries to the path then standard operating system precedence rules apply.

Known common tooling conflicts:

- `cargo install` is known to override binaries in the nix store
- `rustup` is known to override `cargo` and `nightly` versions of rust

#### cargo installed binaries

Use `which` to see where a binary is currently located.

For anything installed with `cargo` the easiest thing is to simply delete the binary.

Any path starting with `/nix/store` should be correctly managed by nix.

Nix shell tries to mitigate the risk of cargo compiling binaries to a global location by setting `$CARGO_HOME` and `$CARGO_INSTALL_ROOT` to the current directory (at the time of building the shell) and places this at the start of `$PATH` (for the duration of the nix shell).

<script
 id="asciicast-264021"
 src="https://asciinema.org/a/264021.js"
 data-autoplay="true"
 data-theme="solarized-light"
 data-rows="20"
 async>
</script>

#### rustup

For `rustup`, depending on the nature of the conflict it may be necessary to uninstall `cargo` versions or `rustup` itself.

## Shell isolation

As the nix shell mostly _adds_ to the shell environment it is possible for existing environment state to bleed into the nix environment.

Usually this is the behaviour we want, e.g. sourcing our `.bashrc` files etc. so that the shell still feels familiar.

In some cases, such as the `$PATH` conflicts discussed above, we want a more aggressively isolated shell environment.

There are three levels of `nix-shell` that are used commonly for everyday usage and debugging.

- `nix-shell` is the standard isolation level
- `nix-shell --pure` means the environment "is almost entirely cleared" but `$HOME`, `$USER` and `$DISPLAY` are retained as well as `~/.bashrc`
- `PS1="" nix-shell --pure --keep PS1` is a pure environment with all environment variables cleared

If you are seeing an issue in the nix-shell that you cannot reproduce on another machine try increasing the shell isolation to debug.
