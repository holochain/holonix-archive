let
  # https://vaibhavsagar.com/blog/2018/05/27/quick-easy-nixpkgs-pinning/
  inherit (import <nixpkgs> {}) fetchgit;

  # nixos holo-host channel @ 2019-04-02
  channel-holo-host = fetchgit {
   url = "https://github.com/NixOs/nixpkgs.git";
   rev = "40baa1f2de4abda35dc93d5dacedcccc2d72238a";
   sha256 = "19sksk1i7q92x7h8q655l68ykrgknmxc3drlk0cjzjn2mp3np5xs";
  };

  # the mozilla rust overlay
  # allows us to track cargo nightlies in a nixos friendly way
  # avoids rustup
  # not compatible with parallel rustup installation
  moz-overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/50bae918794d3c283aeb335b209efd71e75e3954.tar.gz);

  pkgs = import channel-holo-host {
   overlays = [ moz-overlay ];
  };
in
pkgs
