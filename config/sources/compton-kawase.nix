{ pkgs }: let src = pkgs.fetchFromGitHub {
  owner  = "tryone144";
  repo   = "compton";
  rev = "e01494c0cb34dcb4e954a1d2542f5de922fcb01d";
  sha256 = "0s153fqw3r79jk37qs1jwg72hkrcjrg51xpv0zf5yg77h2vxck2m";
}; in src // {
  meta = src.meta // {
    branch = "feature/dual_kawase";
  };
}
