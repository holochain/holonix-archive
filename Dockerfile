FROM nixorg/nix:circleci

# keep this matching nix-shell!
ENV NIX_PATH nixpkgs=https://github.com/NixOs/nixpkgs-channels/tarball/8634c3b619909db7fc747faf8c03592986626e21
ENV HC_TARGET_PREFIX /tmp/holochain

# run a no-op to warm the nix store
RUN nix-shell https://holochain.love --run "echo 1" --show-trace

# Push to Docker hub holochain/holonix:latest