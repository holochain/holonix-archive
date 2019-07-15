# Changelog
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
