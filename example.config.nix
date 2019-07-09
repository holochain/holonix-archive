{
 release = {
  # the commit hash that the release process should target
  # this will always be behind what ends up being deployed
  # the release process needs to add some commits for changelog etc.
  commit = "cc979fe160f21e22d57473305677f82d18ae0b7b";

  # the semver for prev and current releases
  # the previous version will be scanned/bumped by release scripts
  # the current version is what the release scripts bump *to*
  version = {
   current = "0.0.8";
   previous = "0.0.7";
  };

  # canonical upstream name as per `git remote -v`
  upstream = "origin";
 };
}
