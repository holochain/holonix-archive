FROM nixorg/nix:circleci

# need $USER to be set for CI, cargo, etc.
# it isn't set by default
USER root
ENV USER root

# keep this matching nix-shell!
ENV NIX_PATH nixpkgs=channel:nixos-19.09

# run a no-op to warm the nix store
RUN nix-shell https://holochain.love --run "echo 1" --show-trace

# Push to Docker hub holochain/holonix:latest
