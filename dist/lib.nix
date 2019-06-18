{ pkgs, rust, dist, git }:
rec {
 artifact-name = args: "${args.name}-v${dist.version}-${args.target}";

 artifact-url = args: "${dist.github.base-url}/releases/download/v${dist.version}/${artifact-name args}.tar.gz";

 normalize-artifact-target = target:
  builtins.replaceStrings
    [ "unknown" ]
    [ "generic" ]
    target
 ;

 artifact-target = normalize-artifact-target ( if pkgs.stdenv.isDarwin then rust.generic-mac-target else rust.generic-linux-target );

 binary-derivation = args:
  pkgs.stdenv.mkDerivation {
   name = "${args.binary}";

   src = pkgs.fetchurl {
    url = artifact-url ( { target = artifact-target; } // args );
    sha256 = if pkgs.stdenv.isDarwin then args.sha256.darwin else args.sha256.linux;
   };

  unpackPhase = "tar --strip-components=1 -zxvf $src";

  installPhase =
  ''
  mkdir -p $out/bin
  mv ${args.binary} $out/bin/${args.binary}
  '';

  postFixup =
    if
      pkgs.stdenv.isDarwin
    then
      ''
      echo;
      ''
    else
      ''
      patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/bin/${args.binary}
      patchelf --shrink-rpath $out/bin/${args.binary}
      '';
  };

}
