# Example: Custom Holochain And Binaries

The following `shell.nix` file can be used in your project's root folder and activated with `nix-shell`.
It uses a custom revision and a custom set of binaries to be installed.

```nix
let
  holonixPath = builtins.fetchTarball {
    url = "https://github.com/holochain/holonix/archive/develop.tar.gz";
  };

  holonix = import (holonixPath) {
    include = {
        # making this explicit even though it's the default
        holochainBinaries = true;
    };

    holochainVersionId = "custom";

    holochainVersion = {
      rev = "092df23697b7fdd53f901ec4c3a8579c280bae3f";
      sha256 = "1z0y1bl1j2cfv4cgr4k7y0pxnkbiv5c0xv89y8dqnr32vli3bld7";
      cargoSha256 = "1jiz9y1d4ybh33h1ly24s7knsqyqjagsn1gzqbj1ngl22y5v3aqh";
      bins = {
        holochain = "holochain";
        hc = "hc";
        kitsune-p2p-proxy = "kitsune_p2p/proxy";
      };

      lairKeystoreHashes = {
        sha256 = "1jiz9y1d4ybh33h1ly24s7knsqyqjagsn1gzqbj1ngl22y5v3aqh";
        cargoSha256 = "0agykcl7ysikssfwkjgb3hfw6xl0slzy38prc4rnzvagm5wd1jjv";
      };
    };
  };

in holonix.main
```
