# Changelog
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

{{ version-heading }}

### Added
* Convenient script for running the holonix shell. The short-term command will look like this:

    `nix-build https://holochain.love --no-link -A pkgs.holonix`

#### RSM binaries for Linux
* holochain: 0.0.1
* dna-util: 0.0.1 lair-keystore
* lair-keystore: 0.0.1-alpha.10

Binaries are available for Darwin and Linux on `x86_64-linux` and `arm64`.

### Changed
* perf: 4.19 -> 5.4

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
