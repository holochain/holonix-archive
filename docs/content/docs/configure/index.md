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

### Summary

This is the normal approach for "serious" work.

A dedicated nix derivation is created for each project with three parts:

- a reference to holonix
- a configuration file
- custom extensions (optional)

It balances extensibility and configurability against conventions and stability.

The intent is to allow teams to co-ordinate effectively with minimal boilerplate.

Basic nix understanding is needed to initially setup the repository. Once the repository is setup it is comparable to the `holochain.love` approach for ease of use.

### Details

Holonix includes two files that contain "live boilerplate".

They are `example.default.nix` and `example.config.nix`.

They are called `example.*` so that they aren't used by the shell when holonix is directly referenced by url (see above).

`example.default.nix`:

<script src="https://gist-it.appspot.com/github.com/holochain/holonix/blob/develop/example.default.nix"></script>

`example.config.nix`:

<script src="https://gist-it.appspot.com/github.com/holochain/holonix/blob/develop/example.config.nix"></script>

#### How to holonixify a repo

Follow these steps to holonixify a repo:

0. Copy `example.default.nix` into the repo root as `default.nix`
0. Copy `example.config.nix` into the repo root as `config.nix`
0. Change `config = import ./example.config.nix;` in `default.nix` to point to `config.nix`
0. Change `release.version.current` to `0.0.1` and `release.version.previous` to `_._._` in `config.nix`
0. Change `release.owner` to the owner of your github repository
0. Change `release.repo` to the name of your github repository

That's it!

#### How to use a holonixified repo

Point `nix-shell` to the repository.

Nix shell will detect the `default.nix` file and import the `config.nix` to build.

This can be a local checkout or a github url.

<script
 id="asciicast-263683"
 src="https://asciinema.org/a/263683.js"
 data-autoplay="true"
 data-theme="solarized-light"
 data-rows"10"
 async>
</script>

#### How to upgrade holonix

The preferred way to pull new versions of holochain binaries is from new holonix versions.

Every new holochain binary release is tracked with a new holonix release. Some holonix releases don't include a new holochain binary.

Committing holonix versions explicitly rather than manually tracking binaries ensures:

- New supporting dependencies will be available in holonix
- Rolling code back and forward or across branches switches holonix versions and also to the correct binaries

This is important for zome development as HDK/conductor API changes can break zome code. Explicitly tracking holonix versions alongside zome code fixes keeps local development environment versions synced with the relevant conductor and other dependencies.

The version of holonix is set in `config.nix` as `holonix.github.ref`.

The version is cached by the sha as `holonix.github.sha256`.

To change the version of holonix:

0. Change `holonix.github.sha256` slightly to bust nix's internal cache
0. Attempt to drop into the nix shell, it will error with "hash mismatch"
0. Set `holonix.github.ref` to the new version (can be a git commit, branch or tag)
0. Attempt to drop into the nix shell, it will error with "hash mismatch"
0. Copy the "got:" hash for the new ref to `holonix.github.ref`
0. Attempt to drop into the nix shell, it should work now!

#### How to extend holonix

The easiest way to extend holonix is to add your own `buildInputs` to `default.nix`.

There will be some boilerplate that looks like this:

```
buildInputs = [ ]
 ++ holonix.shell.buildInputs
 ++ config.buildInputs
;
```

Add new `buildInputs` by creating `foo/default.nix` files in your project and calling them with `holonix.pkgs.callPackage` like this:

```
buildInputs = [ ]
 ++ holonix.shell.buildInputs
 ++ config.buildInputs

 # main test script
 ++ (holonix.pkgs.callPackage ./foo {
  pkgs = holonix.pkgs;
 }).buildInputs
```

Let's break down what this is doing:

- `buildInputs = [ ]` sets up an empty list of `buildInputs` (derivations to include in the shell)
- `++ ...` appends `...` to the list with `++` operator
- `++ ( ... ).buildInputs` executes `( ... )` then appends the `buildInputs` property to the list
- `holonix.pkgs.callPackage ./foo { pkgs = holonix.pkgs; }` reads and calls the contents of `./foo/default.nix` as a function with the `pkgs` argument set to `holonix.pkgs`

So we are passing the `pkgs` from `holonix` into `./foo/default.nix` (which is a function) and then appending the `buildInputs` from the return to our top level `buildInputs`.

For example, to include a new dependency on the `elixir` language.

0. Visit [NixOS packages search](https://nixos.org/nixos/packages.html) and search for `elixir`
0. The package is there and has a link to the [elixir](https://elixir-lang.org/) homepage so we know it is what we are looking for
0. Create a `./elixir/default.nix` file in our repository
0. Include `pkgs.elixir` in the returned `buildInputs`
0. Use `callPackages` to append this to the `buildInputs` in `default.nix`

Which looks like:

`./elixir/default.nix`

```
{ pkgs }:
{
 buildInputs = [ pkgs.elixir ];
}
```

- `{ pkgs }:` a function with named argument `pkgs`
- `{ buildInputs = ..; }` the function returns a key/value set with a key `buildInputs` and value `...`

`./default.nix`

```
buildInputs = [ ]
 ++ holonix.shell.buildInputs
 ++ config.buildInputs

 ++ (holonix.pkgs.callPackage ./elixir {
  pkgs = holonix.pkgs
 }).buildInputs
 ;
```

#### Using a local copy of holonix

Set `holonix.use-github` to `false` and `holonix.local.path` to the local holonix path relative to the `default.nix` file.

#### Using a fork of holonix

Set `holonix.use-github` to `true` and `holonix.github.owner` to the owner of the fork and `holonix.github.repo` to the fork's repository name.

#### c.f. npm run

It is possible to extend your local `default.nix` with [ad-hoc bash scripts](/docs/bash) so that `nix-shell --run foo` works like a generalised version `npm run foo`.

From https://docs.npmjs.com/cli/run-script

> In addition to the shell’s pre-existing `PATH`, `npm run` adds `node_modules/.bin` to the `PATH` provided to scripts. Any binaries provided by locally-installed dependencies can be used without the `node_modules/.bin` prefix.

Where `npm run foo` adds binaries and packages managed by `npm` to the `PATH`, `nix-shell --run foo` can add almost anything to `PATH`.

Nix shell can also include one of [several versions of node](https://nixos.org/nixos/packages.html#nodejs) to facilitate writing `npm run *` scripts predictably inside the nix shell.

We recommend keeping `npm` _inside_ the nix shell rather than trying to "npmify" nix shell. This is because the `npm` ecosystem is sensitive to semver of `node` itself.

Set a version of `npm` that works for the holonixified project in the `buildInputs` for `./node/default.nix` and then use it inside a nix shell across the whole team, rather than ad-hoc `nvm` management.

See the [node writeup](/docs/node) for more info.

#### c.f. makefiles

It is possible to use makefiles in combination with nix shell.

Nix can even help [ship make](https://nixos.org/nixos/packages.html#gnumake) to platforms where it is not installed by default such as Mac OS X.

This combination is useful because:

- `make` is a very old and trusted standard for tooling
- `nix-shell` can provide dependencies and environment variables that `make` _assumes_

Adding a `Makefile` to a project can help interoperability with other systems and human expectations.

The question is whether to "wrap make in nix" or "wrap nix in make".

Should we run `nix-shell --run 'make foo'` or `make foo` with `foo` running `nix-shell` internally?

There are pros and cons to both approaches.

Wrapping nix in make `make foo`:

- Familiar and interoperable `make *` syntax
- Boot a nix shell for each command (slow but always fresh)
- Ensures correct nix shell and context for _this project_
- Much harder to audit if nix is not used consistently internally to `make` for all commands

Wrapping make in nix `nix-shell --run 'make foo'`:

- New non-standard `nix-shell --run *` syntax
- Optional re-use of nix shell (faster, maybe stale)
- Can make mistakes and use the wrong shell for a project
- Makefile does not work without implicit nix-shell

See the [makefile writeup](/docs/makefile) for more info.

#### How to manage releases with holonix

See [the releases writeup](/docs/release).

### Benefits

Ability to lock down all dependencies across teams, branches, commits, and operating systems.

Zome repositories can define the holonix (and therefore conductor) versioni they are compatible with per-commit.

Supports both local and url based usage like `https://holochain.love` but for individual projects.

Can be extended through `buildInputs` to include additional upstream dependencies and/or custom bash scripts.

Can be customised to integrate with conventional workflows such as release management.

### Limitations

Requires initial setup of `default.nix` and `config.nix` boilerplate files.

Requires some basic nix knowledge to add `buildInputs`.

Project-specific configuration is not portable to other projects.

## NixOS overlay

{{ coming soon }}

https://github.com/holochain/holonix/issues/30
