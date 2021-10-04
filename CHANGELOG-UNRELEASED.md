# Changelog
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

{{ version-heading }}

### Added
* Convenient script for running the holonix RSM alpha shell. The short-term command will look like this:

    `$(nix-build https://nightly.holochain.love --no-link -A pkgs.holonix)/bin/holonix`

* `binaryen` tool as part of the _happs_ component

#### RSM binaries for `arm64`

Binaries are now available for Darwin and Linux `arm64` as well
