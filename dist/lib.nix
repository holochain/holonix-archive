{ pkgs, dist, rust, git, node, darwin }:
rec {
 artifact-name = args: "${args.name}-${dist.version}-${args.target}";

 artifact-url = args: "${dist.github.base-url}/releases/download/${dist.version}/${artifact-name args}.tar.gz";

 normalize-artifact-target = target:
  builtins.replaceStrings
    [ "unknown" ]
    [ "generic" ]
    target
 ;

 artifact-target = normalize-artifact-target ( if pkgs.stdenv.isDarwin then rust.generic-mac-target else rust.generic-linux-target );

 binary-derivation = args:
  # define a few bash snippets to help define our phases
  let
   # binaries are built upstream in ubuntu so we need to fix the linker
   patchelf = ''
   patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/bin/${args.binary}
   patchelf --shrink-rpath $out/bin/${args.binary}
   '';

   wrap-program = ''
   wrapProgram $out/bin/${args.binary} \
    --prefix PATH : "${pkgs.lib.makeBinPath ( darwin.buildInputs ++ args.deps)}" \
    --prefix NIX_LDFLAGS "" "${darwin.ld-flags}" \
    --set CXX ${node.clang}/bin/clang++ \
    --prefix LD_LIBRARY_PATH : "${pkgs.stdenv.lib.makeLibraryPath [
      pkgs.zlib
      pkgs.openssl
     ]}"
   '';
  in
  pkgs.stdenv.mkDerivation {
   name = "${args.binary}";

   src = (pkgs.fetchurl {
    url = artifact-url ( { target = artifact-target; } // args );
    sha256 = if pkgs.stdenv.isDarwin then args.sha256.darwin else args.sha256.linux;
   });

   nativeBuildInputs = [ pkgs.makeWrapper ];

   unpackPhase = "tar --strip-components=1 -zxvf $src";

   installPhase =
   ''
   mkdir -p $out/bin
   mv ${args.binary} $out/bin/${args.binary}
   chmod +x $out/bin/${args.binary}
   '';

   postFixup =
     if
       pkgs.stdenv.isDarwin
     then
       ''
       # don't patchelf on darwin as binaries are all built on darwin upstream
       ${wrap-program}
       ''
     else
       ''
       # need to patchelf as binaries are all built on ubuntu upstream
       ${patchelf}
       ${wrap-program}
       '';
  };

}
