{ lib, ... }:
{
  atLeastVersion = (version: packages: lib.head (lib.filter (d: (lib.versionAtLeast (lib.getVersion d) version)) packages ));
  latestVersion = (packages: lib.head (builtins.sort ( a: b: (lib.getVersion a) > (lib.getVersion b)) packages));
}
