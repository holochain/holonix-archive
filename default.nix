# This is the default nix file FOR HOLONIX
# This file is what nix will find when hitting this repo as a tarball
# This means that downstream consumers should pkgs.callPackage this file
# See example.default.nix for an example of how to consume this file downstream
{
 # allow consumers to pass in their own config
 # fallback to empty sets
 config ? import ./config.nix
 , holo-nixpkgs ? config.holo-nixpkgs.importFn {}
 , includeHolochainBinaries ? include.holochainBinaries or true
 , include ? { }

 # either of: hpos, develop, main, custom. when "custom" is set, `holochainVersion` needs to be specified
 , holochainVersionId? "develop"
 , holochainVersion ? (if holochainVersionId == "custom"
                       then null
                       else builtins.getAttr holochainVersionId holo-nixpkgs.holochainVersions
                      )
 , holochainOtherDepsNames ? [ "lair-keystore" ]
}:

assert (holochainVersionId == "custom") -> holochainVersion != null;

let
 pkgs = import holo-nixpkgs.path {
  overlays = holo-nixpkgs.overlays
    ++ [
      (self: super: {
        holonix = ((import <nixpkgs> {}).callPackage or self.callPackage) ./pkgs/holonix.nix {
          inherit holochainVersionId holochainVersion;
        };
        holonixIntrospect = self.callPackage ./pkgs/holonix-introspect.nix { pkgsOfInterest = self.holochainBinaries; };

        # these are referenced in holochain-s merge script.
        # ideally we'd expose all packages in this repository in this way.
        hnRustClippy = builtins.elemAt (self.callPackage ./rust/clippy {}).buildInputs 0;
        hnRustFmtCheck = builtins.elemAt (self.callPackage ./rust/fmt/check {}).buildInputs 0;
        hnRustFmtFmt = builtins.elemAt (self.callPackage ./rust/fmt/fmt {}).buildInputs 0;
        inherit holochainVersionId;
        holochainBinaries =
          if holochainVersionId == "custom" then
            holo-nixpkgs.mkHolochainAllBinariesWithDeps (holochainVersion // {
              otherDeps =
                super.lib.attrsets.filterAttrs (name: value:
                  super.lib.lists.any (elem: elem == name) holochainOtherDepsNames
                ) holo-nixpkgs
                ;
            })
          else
            (builtins.getAttr holochainVersionId holo-nixpkgs.holochainAllBinariesWithDeps)
          ;
      })
    ]
    ;

};

 components = {
  rust = pkgs.callPackage ./rust {
     inherit config;
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
     pkgs
     config
     ;
  };
  happs = pkgs.callPackage ./happs { };
 };

 optionalComponents = pkgs.lib.mapAttrs (name: value:
    if include."${name}" or true
    then value
    else { buildInputs = []; }
 ) components;

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
    ]
    ++ (if !includeHolochainBinaries then [] else
      (builtins.attrValues pkgs.holochainBinaries)
    )
    ;
 };

 # override and overrideDerivation cannot be handled by mkDerivation
 derivation-safe-holonix-shell = (removeAttrs holonix-shell ["override" "overrideDerivation"]);

in rec
{
 inherit
  holo-nixpkgs
  pkgs
  # expose other things
  ;

inherit (components)
  rust
  ;

 # export the set used to build shell alongside the main derivation
 # downstream devs can extend/override the shell as needed
 # holonix-shell provides canonical dev shell for generic work
 shell = derivation-safe-holonix-shell;
 main = derivation-safe-holonix-shell;
}
