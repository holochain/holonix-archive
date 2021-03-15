# Changelog
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

{{ version-heading }}

### Added
* Convenient script for running the holonix RSM alpha shell. The short-term command will look like this:

    `$(nix-build https://nightly.holochain.love --no-link -A pkgs.holonix)/bin/holonix`
* `hn-introspect` script to list which holochain packages were pulled in for the nix-shell

#### RSM binaries for Linux
* holochain: 0.0.1
* hc: 0.1.0
* lair-keystore: 0.0.1-alpha.10
* kitsune-p2p-proxy: 0.0.1

Binaries are available for Darwin and Linux on `x86_64-linux` and `arm64`.

#### Configurable holochain/holo-nixpkgs versions
* Add a section for holo-nixpkgs to config.nix
* Introduce arguments for choosing the included holochain binaries:
  * holochainVersionId: can be one of "hpos", "main", "develop", or "custom" as of now.
  * holochainVersion: if `holochainVersionId` is "custom", this specifies a set with holochain source information. Example:
    ```nix
      version = "2021-02-05";
      rev = "fd8049a48ac12ef3e190b48a79ffe8d8b5948caa";
      sha256 = "065kkmmr8b5ngjqpr7amd7l4dcakj2njx168qvr5z47mmqs9xbgw";
      cargoSha256 = "1ix8ihlizjsmx8xaaxknbl0wkyck3kc98spipx5alav8ln4wf46s";
    ```

    Altogether the invocation could look like:
    ```console
        nix-shell . --argstr holochainVersionId "custom" --arg holochainVersion '{
          version = "custom";
          rev = "fd8049a48ac12ef3e190b48a79ffe8d8b5948caa";
          sha256 = "065kkmmr8b5ngjqpr7amd7l4dcakj2njx168qvr5z47mmqs9xbgw";
          cargoSha256 = "1ix8ihlizjsmx8xaaxknbl0wkyck3kc98spipx5alav8ln4wf46s";
        }'
    ```
  * holochainOtherDepsNames: list of package names to include in the shell. Names are keys to `holo-nixpkgs`. Example that is also the default: `[ "lair-keystore" ]`



### Changed
* perf: 4.19 -> 5.4
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
