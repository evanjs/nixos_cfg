{ lib, ... }:
with lib;
{
  atLeastVersion = (version: packages: head (filter (d: (versionAtLeast (getVersion d) version)) packages ));
  latestVersion = (packages: head (sort ( a: b: (getVersion a) > (getVersion b)) packages));
}
