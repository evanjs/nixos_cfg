{ config, pkgs, lib, ... }:
with lib;
let
  extension_priority = [
    "full"
    "with-utilties"
    "base"
    "std-only"
  ];

  hasXzUrl = extensionOption: (lib.hasAttr "xz_url" (lib.getAttr extensionOption pkgs.nightly-rust-with-extensions ));

  firstAvailable = extensions: (findFirst extensions (name: (hasXzUrl name) == true).name);
in
  {
    environment.systemPackages = [
      (firstAvailable)
    ];
  }

