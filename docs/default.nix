{ callPackage, hugo, asciinema, writeShellScriptBin }:
{
  buildInputs =
    [
      hugo
      asciinema

      (writeShellScriptBin "hn-docs" ''
        (cd docs && hugo serve )
      '')
    ]
    ++ (callPackage ./github-pages { }).buildInputs
  ;
}
