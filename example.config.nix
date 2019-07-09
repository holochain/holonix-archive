{
 release = {
  # the commit hash that the release process should target
  # this will always be behind what ends up being deployed
  # the release process needs to add some commits for changelog etc.
  commit = "d6dcdd73ebaa944bf9df09b6f17e8654c5a9427d";

  # the semver for prev and current releases
  # the previous version will be scanned/bumped by release scripts
  # the current version is what the release scripts bump *to*
  version = {
   current = "0.0.7";
   previous = "0.0.6";
  };

  # canonical upstream name as per `git remote -v`
  upstream = "origin";
 };
}
