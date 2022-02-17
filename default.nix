# This is the default nix file FOR HOLONIX
# This file is what nix will find when hitting this repo as a tarball
# This means that downstream consumers should pkgs.callPackage this file
# See example.default.nix for an example of how to consume this file downstream
{
  # allow consumers to pass in their own config
  # fallback to empty sets
  config ? import ./config.nix
, holochain-nixpkgs ? config.holochain-nixpkgs.importFn { }
, includeHolochainBinaries ? include.holochainBinaries or true
, include ? { test = false; }

  # either one listed in VERSIONS.md or "custom". when "custom" is set, `holochainVersion` needs to be specified
, holochainVersionId ? "develop"
, holochainVersion ? null
, rustVersion ? { }
, rustc ? (if rustVersion == { }
  then holochain-nixpkgs.pkgs.rust.packages.stable.rust.rustc
  else
    holochain-nixpkgs.pkgs.rust.mkRust ({
      track = "stable";
      version = "latest";
    } // (if rustVersion != null then rustVersion else { }))
  )
}:

let
  holochainVersionFinal =
    if holochainVersionId == "custom"
    then
      if holochainVersion == null
      then throw ''When 'holochainVersionId' is set to "custom" a value to 'holochainVersion' must be provided.''
      else holochainVersion
    else
      (
        let
          value = builtins.getAttr holochainVersionId holochain-nixpkgs.packages.holochain.holochainVersions;
        in

        if holochainVersion != null
        then builtins.trace ''WARNING: ignoring the value of `holochainVersion` because `holochainVersionId` is not set to "custom"'' value
        else value
      )
  ;
in

assert (holochainVersionId == "custom") -> (
  let
    deprecatedAttributes = builtins.filter
      (elem: builtins.elem elem [ "cargoSha256" "bins" "lairKeystoreHashes" ])
      (builtins.attrNames holochainVersionFinal);
  in

  if [ ] != deprecatedAttributes
  then
    (
      let
        holonixPath = builtins.toString ./.;
      in

      throw ''
        The following attributes found in the 'holochainVersion' set are no longer supported:
        ${builtins.concatStringsSep ", " deprecatedAttributes}

        The structure of 'holochainVersion' changed in a breaking way,
        and more supported values were added to 'holochainVersionId'.

        Please see if a matching 'holochainVersionId' for your desired version already exists:
        - ${holonixPath}/VERSIONS.md

        If not please take a look at the updated readme and example files for custom holochain versions:
        - ${holonixPath}/examples/custom-holochain

        If you're in a hurry you can rollback to holonix revision
        d326ee858e051a2525a1ddb0452cab3085c4aa98 or before.
      ''
    )
  else true
);

let
  pkgs = import holochain-nixpkgs.pkgs.path {
    overlays = (builtins.attrValues holochain-nixpkgs.overlays)
      ++ [
      (self: super: {
        custom_rustc = rustc;

        holonix = ((import <nixpkgs> { }).callPackage or self.callPackage) ./pkgs/holonix.nix {
          inherit holochainVersionId holochainVersion;
        };
        holonixIntrospect = self.callPackage ./pkgs/holonix-introspect.nix {
          inherit (self) holochainBinaries;
        };

        holonixVersions = self.callPackage ./pkgs/holonix-versions.nix { };

        # these are referenced in holochain-s merge script.
        # ideally we'd expose all packages in this repository in this way.
        hnRustClippy = builtins.elemAt (self.callPackage ./rust/clippy { }).buildInputs 0;
        hnRustFmtCheck = builtins.elemAt (self.callPackage ./rust/fmt/check { }).buildInputs 0;
        hnRustFmtFmt = builtins.elemAt (self.callPackage ./rust/fmt/fmt { }).buildInputs 0;
        inherit holochainVersionId;
        holochainBinaries = holochain-nixpkgs.packages.holochain.mkHolochainAllBinariesWithDeps holochainVersionFinal;
      })
    ]
    ;

  };

  components = {
    rust = pkgs.callPackage ./rust {
      inherit config rustc;
    };
    node = pkgs.callPackage ./node { };
    git = pkgs.callPackage ./git { };
    linux = pkgs.callPackage ./linux { };
    docs = pkgs.callPackage ./docs { };
    openssl = pkgs.callPackage ./openssl { };
    release = pkgs.callPackage ./release {
      config = config;
    };
    test = pkgs.callPackage ./test {
      inherit
        config
        ;
    };
    happs = pkgs.callPackage ./happs { };
  };

  optionalComponents = pkgs.lib.mapAttrs
    (name: value:
      if include."${name}" or true
      then value
      else { buildInputs = [ ]; }
    )
    components;

  holonix-shell = pkgs.callPackage ./nix-shell {
    inherit
      pkgs
      ;

    inherit (components)
      rust
      ;

    inherit (optionalComponents)
      docs
      git
      linux
      node
      openssl
      release
      test
      happs
      ;
    extraBuildInputs = [
      pkgs.holonixIntrospect
      pkgs.holonixVersions
    ]
    ++ (if !includeHolochainBinaries then [ ] else
    (builtins.attrValues pkgs.holochainBinaries)
    )
    ;
  };

  # override and overrideDerivation cannot be handled by mkDerivation
  derivation-safe-holonix-shell = (removeAttrs holonix-shell [ "override" "overrideDerivation" ]);

in
rec
{
  inherit
    holochain-nixpkgs
    pkgs
    # expose other things
    ;

  inherit (components)
    rust
    ;

  # export the set used to build shell alongside the main derivation
  # downstream devs can extend/override the shell as needed
  # holonix-shell provides canonical dev shell for generic work
  main = derivation-safe-holonix-shell;
}
