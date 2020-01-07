{ stdenv, ghcWithPackages, makeWrapper, packages }:

let
  pname = "taffybar-with-packages";
  taffybarEnv = ghcWithPackages (self: [ self.taffybar ] ++ packages self);
in stdenv.mkDerivation {
  name = "taffybar-with-packages-${taffybarEnv.version}";

  nativeBuildInputs = [ makeWrapper ];

  buildCommand = ''
    #install -D ${taffybarEnv}/share/man/man1/taffybar.1.gz $out/share/man/man1/taffybar.1.gz
    makeWrapper ${taffybarEnv}/bin/taffybar $out/bin/taffybar \
      --set NIX_GHC "${taffybarEnv}/bin/ghc" \
  '';

  # trivial derivation
  preferLocalBuild = true;
  allowSubstitutes = false;
}
