# Changelog
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

{{ version-heading }}

### Added

- Added `watch` cli commands
- $USER is set in Dockerfile
- hc cli tool has dependencies set e.g. for nix-env installations

### Changed

- conductor and cli versions 0.0.29-alpha2

### Deprecated

### Removed

- qt removed

### Fixed

- `hc-rust-manifest-list-unpinned` won't traverse `.cargo/` anymore which resulted in false positives [PR#58](https://github.com/holochain/holonix/pull/58)

### Security
