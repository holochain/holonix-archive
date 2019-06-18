{ pkgs }:
let
 # https://stackoverflow.com/questions/51161225/how-can-i-make-macos-frameworks-available-to-clang-in-a-nix-environment
 frameworks = if pkgs.stdenv.isDarwin then pkgs.darwin.apple_sdk.frameworks else {};
 ld-flags = if pkgs.stdenv.isDarwin then "-F${frameworks.CoreFoundation}/Library/Frameworks -framework CoreFoundation " else "";
in
{
 frameworks = frameworks;
 ld-flags = ld-flags;
 buildInputs = []
 ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [ frameworks.Security frameworks.CoreFoundation frameworks.CoreServices ];
}
