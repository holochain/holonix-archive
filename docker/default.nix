{
 pkgs
}:
let

  nix = pkgs.writeShellScriptBin "hn-docker-build-nix"
  ''
  docker build ./docker -f docker/Dockerfile.nix
  '';

  ubuntu = pkgs.writeShellScriptBin "hn-docker-build-ubuntu"
  ''
  docker build ./docker -f docker/Dockerfile.ubuntu
  '';

  debian = pkgs.writeShellScriptBin "hn-docker-build-debian"
  ''
  docker build ./docker -f docker/Dockerfile.debian
  '';
in
{
 buildInputs = [ nix ubuntu debian ];
}
