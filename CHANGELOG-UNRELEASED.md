# Changelog
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

{{ version-heading }}

### Added
* Convenient script for running the holonix RSM alpha shell. The short-term command will look like this:

    `$(nix-build https://nightly.holochain.love --no-link -A pkgs.holonix)/bin/holonix`
* `hn-introspect` script to list which holochain packages were pulled in for the nix-shell

#### RSM binaries for Linux
* holochain: 0.0.103
* hc: 0.0.4
* lair-keystore: 0.0.3
* kitsune-p2p-proxy: 0.0.3

Binaries are available for Darwin and Linux on `x86_64-linux` and `arm64`.

#### Configurable holochain/holochain-nixpkgs versions
* Add a section for holochain-nixpkgs to config.nix
* Introduce arguments for choosing the included holochain binaries:

  * holochainVersionId: can be one of "hpos", "main", "develop", or "custom" as of now.
  * holochainVersion: if `holochainVersionId` is "custom", this specifies a set with holochain source information.
  * include: a set that controls which components to include in the shell

    Please see the files in _examples/_ for a usage examples.

### Changed
* perf: 4.19 -> 5.4
* perf: 5.4 -> 5.10
* rust: 1.48 -> 1.54
* clippy: 0.0.212 -> 0.1.5*
* Removed the `HC_TARGET_PREFIX` env var in favor of the `NIX_ENV_PREFIX` env var

### Deprecated

### Removed
* n3c
* wasm tools
* rust nightly
* sim2h_server
* newrelic tooling
* saml2aws tool and AWS specific CI jobs
* trycp_server

### Fixed

### Security
