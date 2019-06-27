{ pkgs }:
let
 # rust 2019-06-08
 # b726b41daf9abd351f6b58984f76965a61947818
 # RUSTFLAGS="-A unknown_lints" cargo build
 # https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/rust.section.md
 clippy = pkgs.rustPlatform.buildRustPackage rec {
  version = "f30d2b6891f3710ead6f5e280e6b6ae34715e138";
  name = "clippy-${version}";

  src = pkgs.fetchFromGitHub {
   owner = "holochain";
   repo = "rust-clippy";
   rev = "${version}";
   sha256 = "07si24mbps7vjs6642f1rjrywvl9siv4q4h1r4114nmba57wyxsq";
  };

  cargoSha256 = "0afvkh5qk9f96dginv8k31yaxx5m94bpdp9kiddlsj2l090b0df9";

  meta = with pkgs.stdenv.lib; {
   description = "A bunch of lints to catch common mistakes and improve your Rust code";
   homepage = "https://github.com/rust-lang/rust-clippy";
   license = licenses.mit;
   platforms = platforms.all;
  };
 };

 name = "hn-rust-clippy";

 script = pkgs.writeShellScriptBin name
 ''
 cargo clippy -- \
 -A clippy::nursery -A clippy::style -A clippy::cargo \
 -A clippy::pedantic -A clippy::restriction \
 -D clippy::complexity -D clippy::perf -D clippy::correctness
 '';
in
{
 buildInputs = [
  script
 ];
}
