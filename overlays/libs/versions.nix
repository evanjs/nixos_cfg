{ lib, ... }:
{
  latestVersion = (version: packages: lib.head (lib.filter (d: (lib.versionAtLeast (lib.getVersion d) version)) packages ));
}
