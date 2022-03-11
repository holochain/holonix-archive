{ sources
, writeShellScriptBin
}:

let
  scaffolding = (import sources.scaffolding { }).holochain-create;
  hn-init = writeShellScriptBin "hn-init" ''
    exec ${scaffolding}/bin/holochain-create init ''${@}
  '';
in

{
  buildInputs = [
    scaffolding
    hn-init
  ];
}
