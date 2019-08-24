---
title: 'Release management'
date: 2019-02-11T19:27:37+10:00
weight: 16
---

## workflow

Holonix defines a simple, language agnostic release workflow.

It assumes a `develop` and `master` branch.

It assumes a changelog.

The `release.version.current` is read from `./config.nix` to create a tag `v${release.version.current` for the release.

The workflow runs in three stages:

0. Preflight
0. Version
0. Publish

Each stage runs the hooks (bash scripts) defined in `./config.nix` with the same names:

- `release.hook.preflight`
- `release.hook.version`
- `release.hook.publish`

<div class="mermaid">
graph TB;
  preflight-hook[preflight hook] --> preflight-pass{error code?}
  preflight-pass -->|Yes| exit-noop[exit with no-op]
  preflight-pass -->|No| release-branch[create release branch]
  release-branch --> changelog[release changelog]
  changelog --> version-hook[version hook]
  version-hook --> github-push[push to github]
  github-push --> github-tag[tag and release on github]
  github-tag --> publish-hook[publish hook]
  style preflight-hook fill:white,stroke:red,stroke-width:3px
  style version-hook fill:white,stroke:red,stroke-width:3px
  style publish-hook fill:white,stroke:red,stroke-width:3px
</div>

## hooks

A hook is simply a string in `./config.nix` that will be run as a bash script.

Some standard hooks are offered by holonix.  
New standard hooks are added from time to time.

See the `holochain-rust` repository's [`./config.nix` file](https://github.com/holochain/holochain-rust/blob/develop/config.nix) for an example of a mix of standard holonix hook scripts and repo-specific scripts.

### Preflight

Preflight hooks are sanity checks that must pass before the release is attempted.

Return an exit code other than `0` to cancel the release.

Standard preflight hooks:

- `hn-release-hook-preflight-manual`: prompts the user to type `Y` to confirm the release

### Version

Version hooks are responsible for modifying files in place to move from `release.version.previous` to `release.version.current`.

Holonix always copies and resets the contents of `CHANGELOG-UNRELEASED.md` to the top of `CHANGELOG.md` before version hooks run.

Holonix creates a new git commit after running the version hook and pushes this to github in the release branch.

Standard version hooks:

- `hn-release-hook-version-rust`: updates `version` key in all `Cargo.toml` files for rust crates to `release.version.current`
- `hn-release-hook-version-readme`: updates all instances of `release.version.previous` to `release.version.current` in all files named `readme.md` (case insensitive)

### Publish

Publish hooks are responsible for any actions required to distribute release artifacts downstream.

For example [the lib3h public hook](https://github.com/holochain/lib3h/blob/develop/scripts/nix/release/hook/publish/default.nix) pushes crates to crates.io in dependency order.

Holonix pushes the release branch to github, merges it into both `master` and `develop` and tags the `HEAD` of the release branch with the `v${release.version.current}`.

Holonix always creates a release on github using the `release.github.template` markdown template.

The `{{ changelog }}` placeholder in the release markdown template will be replaced with the changelog notes for this release.

Standard publish hooks:

- {{ coming soon }}

## how to do a release

### requirements

Before attempting a release ensure the following:

- a `develop` branch
- a `master` branch
- a reference to holonix `0.0.30` or higher
- a [github oath token](https://github.com/settings/tokens) added to git config locally

```bash
git config --global hub.oauthtoken "xxxyourtokenxxx"
git config --global hub.username "your-github-username"
```

- a commit ready to release from the `develop` branch pulled and checked out locally
- `cd` into the repository and **do not enter the nix shell**

### process

Check all the above requirements are met.

Review the `CHANGELOG-UNRELEASED.md` file if it exists (it will be created during the release if not).

Update `./config.nix` so that `release.commit` is the commit hash to be released.

The current commit hash can be found by running:

```bash
git rev-parse HEAD
```

Update `./config.nix` so that `release.version.previous` is the old `release.version.current` value and `release.version.current` is now the new release version.

Unlock your ssh key for convenience.

```bash
ssh-add
```

Commit everything so the repository is clean.

```bash
git add .
git commit -am'release prep'
```

Run the release command.

```bash
nix-shell --run hn-release-cut
```
