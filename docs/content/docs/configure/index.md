---
title: 'Configure holonix'
date: 2019-02-11T19:27:37+10:00
weight: 5
---

There are a few ways to configure holonix for a project.

- "zero config" through `https://holochain.love` urls
- pinned per-project with a `default.nix` file
- embedded directly as a native NixOS overlay

Each approach has pros and cons.

The end goal for all approaches is to create a nix shell that includes a set of dependencies that are useful and predictable for development of zomes, core, GUIs, etc.

It is possible to use the `--run` syntax to run scripts ad-hoc within a shell but this takes more time as the shell needs to be rebuilt per-command.

Building the nix shell takes 10-30 seconds. This is reasonable for continuous integration and other automations but can be a bit slow for local development feedback loops.

<script
 id="asciicast-263318"
 src="https://asciinema.org/a/263318.js"
 data-autoplay="true"
 data-theme="solarized-light"
 data-rows="10"
async>
</script>

The usual workflow is for a developer to drop into one or more nix shells before starting work and keep it open for a working session.

**Important:**  
Nix shell only parses and compiles the config from a `default.nix` file (see below) _once_ when it first builds!  

To see new nix config `exit` and rebuild the nix shell to create a fresh session.

## holochain.love

### Summary

Use `holochain.love` and other github urls when you want a basic shell with sane defaults and minimum preparation/knowledge.

This is the best option for beginners, especially anyone feeling overwhelmed by holochain itself, not wanting to _also_ learn NixOS at the same time.

This option is also great for continuous integration or other situations where it helps to decouple dependency management from project-specific concerns (e.g. what repositories are cloned to the local file system).

### Details

Nix shell can build from either a local directory or a url.

- `nix-shell` builds from the current directory like `nix-shell .` would
- `nix-shell {{ path }}` builds from `{{ path }}` locally
- `nix-shell {{ url }}` builds from `{{ url }}` remotely using curl

`{{ path }}` can be either a directory or a compressed archive (e.g. a `.tar.gz` "tarball").

`{{ url }}` must point to an archive.

If `nix-shell` points to a directory it will look for `shell.nix` first, then `default.nix`

If `nix-shell` points to an archive/url it will look for `default.nix` only.

Holonix has its own `default.nix` file that is designed to be consumed by nix shell directly.

The `default.nix` file in the root of the Holonix repository references a blank `config.nix` file so it is unsuitable for project specific workflows such as release management (see below).

Native Github archive functionality can be used to target _any_ commit of holonix.

The general format of holonix Github archives looks like:

```
https://github.com/holochain/holonix/archive/{{ ref }}.tar.gz
```

Where `{{ ref }}` is any valid git ref, e.g. commit, tag, or branch.

`https://holochain.love` is a convenience url that points to the `master` branch of the holonix repo on github.

<script
 id="asciicast-263315"
 src="https://asciinema.org/a/263315.js"
 data-autoplay="true"
 data-theme="solarized-light"
 async>
</script>

### Benefits

When the shell points directly to the root of the holonix repository it pulls everything in with "sane defaults".

This is the approach used by the [holochain quick start guide](https://developer.holochain.org/start.html) as it requires almost no nix knowledge to get up and running.

Using `https://holochain.love` provides the latest holonix code from the `master` branch, give or take a little caching.

Referencing holonix by url decouples usage of the nix shell from the local file system making it very portable. This approach can be used to drop into a consistent nix shell from any computer in any directory.

Using the extended github archive url form allows surgical pinning and "time travel" of holonix and all its dependencies and workflows.

### Limitations

Because the shell uses the "empty" `config.nix` file in the root of the holonix repository, it cannot be configured or extended for a specific project.

Some holonix functionality, such as release management, relies on per-project configuration so isn't supported by direct url references.

Ideally the latest commits on `master` will be tested and work well but mistakes are possible. Even if `master` is working perfectly as intended, breaking changes from dependencies (e.g. new Rust compiler versions) can be disruptive to complex existing projects.

Targetting a specific commit in a github archive url is great for individual developers or small teams but doesn't scale well to many active git branches or large/dynamic team structures.

## default.nix

## NixOS overlay
