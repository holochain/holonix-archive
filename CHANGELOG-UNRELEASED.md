# Changelog
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
l
{{ version-heading }}

### Added
* Convenient script for running the holonix RSM alpha shell. The short-term command will look like this:

    `$(nix-build https://nightly.holochain.love --no-link -A pkgs.holonix)/bin/holonix`

#### RSM binaries for Linux
* holochain: 0.0.1
* dna-util: 0.0.1 lair-keystore
* lair-keystore: 0.0.1-alpha.10
* kitsune-p2p-proxy: 0.0.1

Binaries are available for Darwin and Linux on `x86_64-linux` and `arm64`.

### Changed
* perf: 4.19 -> 5.4
* Removed the `HC_TARGET_PREFIX` env var in favor of the `NIX_ENV_PREFIX` env var

### Deprecated

### Removed
* cli (hc)
* n3c
* wasm tools
* rust nightly
* sim2h_server
* newrelic tooling
* saml2aws tool and AWS specific CI jobs
* trycp_server

### Fixed

### Security
