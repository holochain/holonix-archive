# empty config file full of fallbacks to get default.nix loading
# use this as a minimal template or example.config.nix for a full file
{
 release = {
  commit = "________________________________________";
  version = {
   current = "_._._";
   previous = "_._._";
  };

  hook = {
   preflight = ''
echo "<your preflight script here>"
   '';
   version = ''
echo "<your versioning script here>"
   '';
   publish = ''
echo "<your publishing script here>"
   '';
  };

  github = {
   owner = "<your github owner here>";
   repo = "<your repo name here>";
   template = ''
   {{ changelog }}
   <your release template markdown here>
   '';
  };
 };

 holochain-nixpkgs = rec {
  use-github = true;

  github = rec {
   # can be any github ref
   # branch, tag, commit, etc.
   ref = "26212411e9d1c9455b7a53aae12fe6ac61c681c3";

   # the sha of what is downloaded from the above ref
   # note: even if you change the above ref it will not be redownloaded until
   #       the sha here changes (the sha is the cache key for downloads)
   # note: to get a new sha, get nix to try and download a bad sha
   #       it will complain and tell you the right sha
   sha256 = "18jj5cxdn4z6qpwm03wnkpq2nzcppxz62gj6j86zyy2ydc6hidzb";

   # the github owner of the holonix repo
   owner = "holochain";

   # the name of the holonix repo
   repo = "holochain-nixpkgs";

  };

  # configuration for when use-github = false
  local = {
   # the path to the local holonix copy
   path = ../holochain-nixpkgs;
  };

  pathFn = _:
    if use-github
    then builtins.fetchTarball (with github; {
       url = "https://github.com/${owner}/${repo}/archive/${ref}.tar.gz";
       inherit sha256; }
      )
    else local.path
    ;

  importFn = _: import (pathFn { }) {};
 };
}
