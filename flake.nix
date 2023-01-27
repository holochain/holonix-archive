{
  description = "Deprecated holochain repo (moved to https://github.com/holochain/holochain)";

  inputs = {
    holochain.url = "github:holochain/holochain/pr_holonix_on_flakes";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
      follows = "holochain/flake-compat";
    };
  };

  outputs = inputs: {};
}
