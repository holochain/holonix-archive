# This is an example of what downstream consumers of holonix should do
# This is also used to dogfood as many commands as possible for holonix
# For example the release process for holonix uses this file
let

 # point this to your local config.nix file for this project
 # example.config.nix shows and documents a lot of the options
 project-config = import ./example.config.nix;

 config = {

  # true = use a github repository as the holonix base (recommended)
  # false = use a local copy of holonix (useful for debugging)
  use-github = true;

  # configure the remote holonix github when use-github = true
  github = {

   # can be any github ref
   # branch, tag, commit, etc.
   ref = "0.0.5";

   # the sha of what is downloaded from the above ref
   # note: even if you change the above ref it will not be redownloaded until
   #       the sha here changes (the sha is the cache key for downloads)
   # note: to get a new sha, get nix to try and download a bad sha
   #       it will complain and tell you the right sha
   sha256 = "169xbmj9z6pxqz15r2vk5gd5rqzg0zbw6xmjycspx87822xiyrlg";

   # the github owner of the holonix repo
   owner = "holochain";

   # the name of the holonix repo
   repo = "holonix";
  };

  # configuration for when use-github = false
  local = {
   # the path to the local holonix copy
   path = ./.;
  };

 };

 # START HOLONIX IMPORT BOILERPLATE
 holonix = import (
  if ! config.use-github
  then config.local.path
  else fetchTarball {
   url = "https://github.com/${config.github.owner}/${config.github.repo}/tarball/${config.github.ref}";
   sha256 = config.github.sha256;
  }
 ) { config = project-config; };
 # END HOLONIX IMPORT BOILERPLATE

 # holonix = callPackage ../holonix { config = (import ./config.nix) };
in
with holonix.pkgs;
{
 dev-shell = stdenv.mkDerivation (holonix.shell // {
  name = "dev-shell";

  buildInputs = []
   ++ holonix.shell.buildInputs
  ;
 });
}
