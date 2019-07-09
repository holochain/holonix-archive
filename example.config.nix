{
 release = {
  # the commit hash that the release process should target
  # this will always be behind what ends up being deployed
  # the release process needs to add some commits for changelog etc.
  commit = "6e4945701759d49c97ea5ba9b2ae3500dd8418bd";

  # the semver for prev and current releases
  # the previous version will be scanned/bumped by release scripts
  # the current version is what the release scripts bump *to*
  version = {
   current = "0.0.14";
   previous = "0.0.13";
  };

  github = {
   # markdown to inject into github releases
   # there is some basic string substitution {{ xxx }}
   # - {{ changelog }} will inject the changelog as at the target commit
   template = ''
{{ changelog }}

# Installation

Use Holonix to work with this repository.

See:

- https://github.com/holochain/holonix
- https://nixos.org/
'';

   # owner of the github repository that release are deployed to
   owner = "holochain";

   # repository name on github that release are deployed to
   repo = "holonix";

   # canonical local upstream name as per `git remote -v`
   upstream = "origin";
  };
 };
}
