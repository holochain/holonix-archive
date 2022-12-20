{ sources
, name
, holochainBinaries
}:

{
  buildInputs =
    if builtins.hasAttr name holochainBinaries
    then [ holochainBinaries."${name}" ]
    else builtins.trace "WARN ${name} requested but not found" [];
}
