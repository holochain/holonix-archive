{
  description = "Deprecated holochain repo (moved to https://github.com/holochain/holochain)";

  inputs = {
    holochain.url = "github:holochain/holochain";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
      follows = "holochain/flake-compat";
    };
  };

  outputs = inputs: {};
}
