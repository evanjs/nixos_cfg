let
  rev = "96af698f0cfefdb4c3375fc199374856b88978dc";
  sha256 = "1ar0h12ysh9wnkgnvhz891lvis6x9s8w3shaakfdkamxvji868qa";
          # Get sha256 with e.g.: `nix-prefetch-url --unpack https://github.com/domenkozar/hie-nix/archive/96af698f0cfefdb4c3375fc199374856b88978dc.tar.gz`
in self: super: {
  hies = (import (builtins.fetchTarball {
    url = "https://github.com/domenkozar/hie-nix/archive/${rev}.tar.gz";
    inherit sha256;
  }) {}).hies;
}
