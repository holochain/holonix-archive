{ pkgs
, callPackage
, nodejs_latest
, clang
, yarn
, python
}:

{
  buildInputs =
    [
      # node and yarn version used in:
      # - binary building
      # - app spec tests
      # - deploy scripts
      # - node conductor management
      nodejs_latest
      clang
      yarn

      # needed by node-gyp
      python
    ]
    ++ (callPackage ./flush { }).buildInputs
  ;
}
