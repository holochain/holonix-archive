# Changelog
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

{{ version-heading }}

### Added

- Added dockerfiles for minimal/sim2h_server/trycp_server for binary boxes
- Added utility scripts to make working with docker easier

### Changed

- Changed docker tags to be {box}.{branch}
- Dockers build on love/master/develop (e.g. holochain/holonix:latest.love)

### Deprecated

### Removed

### Fixed

- trycp_server binary is wrapped with holochain to support nix-env installation

### Security
