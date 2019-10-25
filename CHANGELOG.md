# Changelog
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.39] - 2019-10-25

### Added

### Changed

- version 0.0.34-alpha1 of conductors

### Deprecated

### Removed

### Fixed

### Security

## [0.0.38] - 2019-10-23

### Added

- added saml2aws tool

### Changed

- conductor version v0.0.33-alpha5

### Deprecated

### Removed

### Fixed

### Security

## [0.0.37] - 2019-10-14

### Added

- Holochain v0.0.32-alpha2

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.0.36] - 2019-10-04

### Added

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.0.35] - 2019-10-04

### Added

- added github pages documentation

### Changed

### Deprecated

### Removed

- remove $HC_TARGET_PREFIX (moved to holochain-rust)

### Fixed

### Security

## [0.0.34] - 2019-09-18

### Added

### Changed

- core v0.0.30-alpha6

### Deprecated

### Removed

### Fixed

### Security

## [0.0.33] - 2019-09-17

### Added

### Changed

- bump to core v0.0.30-alpha5

### Deprecated

### Removed

### Fixed

### Security

## [0.0.32] - 2019-09-16

### Added

### Changed

- Moved hc-rust-manifest-* to hn-rust-manifest-*
- holochain-rust version 0.0.30-alpha2

### Deprecated

### Removed

- Removed all hc-* commands

### Fixed

### Security

## [0.0.31] - 2019-09-12

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

## [0.0.30] - 2019-08-18

### Added
- Bumped Holochain version to 0.0.28-alpha1

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.0.29] - 2019-08-12

### Added

### Changed


### Deprecated

### Removed

### Fixed
-Fixing release hashes for linux

### Security

## [0.0.29] - 2019-08-12

### Added

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.0.29] - 2019-08-12

### Added

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.0.29] - 2019-08-12

### Added

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.0.29] - 2019-08-12

### Added

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.0.29] - 2019-08-12

### Added

### Changed

- Fixed holonix release

### Deprecated

### Removed

### Fixed

### Security

## [0.0.28] - 2019-08-09

### Added

### Changed

- bump holochain and hc binaries to `0.0.27-alpha1`

### Deprecated

### Removed

### Fixed

### Security

## [0.0.27] - 2019-08-05

### Added

### Changed

- bump holochain and hc binaries to `0.0.26-alpha1`

### Deprecated

### Removed

### Fixed

### Security

## [0.0.26] - 2019-08-05

### Added

### Changed

### Deprecated

### Removed

### Fixed

- Fixed github release process

### Security

## [0.0.25] - 2019-08-05

### Added

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.0.24] - 2019-08-05

### Added

### Changed

### Deprecated

### Removed

### Fixed

- Fixed holonix release process

### Security

## [0.0.23] - 2019-08-05

### Added

- added `RUST_BACKTRACE=1` to nix shell for rust

### Changed

### Deprecated

### Removed

- Removed conductor specific bin scripts

### Fixed

- Fixed the github release hook by removing `-v`

### Security

## [0.0.22] - 2019-07-30

### Added

- Self tests command `hn-test`
- Mac testing on Circle CI
- `bats` for bash testing
- export `$TMP` and `$TMPDIR` in nix shell as `/tmp/tmp.XXXXXXXXXX`

### Changed

- Upgraded github-release for darwin support
- Circle CI runs `hn-test`
- Updated to holochain-rust v0.0.25-alpha1

### Deprecated

### Removed

### Fixed

### Security

## [0.0.21] - 2019-07-16

### Added

### Changed

- bump holochain and hc binaries to `0.0.24-alpha2`

### Deprecated

### Removed

### Fixed

### Security

## [0.0.20] - 2019-07-15

### Added

- add wabt to rust/wasm/default.nix

### Changed

- bumped rust nightly to `2019-07-14`

### Deprecated

### Removed

- many core-only scripts moved to core

### Fixed

### Security

## [0.0.19] - 2019-07-12

### Added

### Changed

- bumped to `0.0.23-alpha1` binaries for conductor and cli

### Deprecated

### Removed

### Fixed

- fixed missing config in default.nix

### Security

## [0.0.18] - 2019-07-09

### Added

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.0.17] - 2019-07-09

### Added

### Changed

- rust version hook no longer requires previous version

### Deprecated

### Removed

### Fixed

### Security

## [0.0.16] - 2019-07-09

### Added

- release hooks for preflight, version, publish

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.0.15] - 2019-07-09

### Added

- added an extension point for buildInputs in example.config.nix

### Changed

- moved holonix configuration to example.config.nix

### Deprecated

### Removed

### Fixed

- fixed touching missing changelog files early enough in release

### Security

## [0.0.14] - 2019-07-09

### Added

### Changed

### Deprecated

### Removed

### Fixed

- fixed a bug where releases fail if changelog files don't already exist

### Security

## [0.0.13] - 2019-07-09

### Added

### Changed

- example.default.nix points to holonix 0.0.12

### Deprecated

### Removed

### Fixed

### Security

## [0.0.12] - 2019-07-09

### Added

### Changed

### Deprecated

### Removed

### Fixed

- release command no longer references medium
- github template no longer includes legacy placeholder

### Security

## [0.0.11] - 2019-07-09

### Added

### Changed

### Deprecated

### Removed

### Fixed

- github releases are deployed correctly

### Security

## [0.0.10] - 2019-07-09

### Added

### Changed

### Deprecated

### Removed

### Fixed

- fixed release cutting without github syncs

### Security

## [0.0.9] - 2019-07-09

### Added

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.0.8] - 2019-07-09

### Added

- scripts to update github repository for cut releases

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.0.8] - 2019-07-09

### Added

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.0.7] - 2019-07-09

### Added

- added hn-release-cut

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.0.6] - 2019-07-09

### Added

- added example.default.nix and example.config.nix to dogfood downstream workflows

### Changed

### Deprecated

### Removed

### Fixed

### Security

## 2019-07-09T04:19:14+00:00

### Added

### Changed

- fallback versioning changelog headings use ISO seconds granularity

### Deprecated

### Removed

### Fixed

### Security

## 2019-07-09

### Added

- ability to pass config into root default.nix from consumers
- hn-release-changelog command

### Changed

### Deprecated

### Removed

### Fixed

### Security
