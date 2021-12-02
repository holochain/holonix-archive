{ sources }:

let
  scaffolding = (import sources.scaffolding { }).holochain-create;
in

{
  buildInputs = [
    scaffolding
  ];
}
