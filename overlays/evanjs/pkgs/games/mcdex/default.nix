{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "mcdex-unstable-2021-01-31";
  rev = "466d1ef8449b77aadf3025cb84809fe743bcdbf8";


  src = fetchFromGitHub {
    inherit rev;
    owner = "dizzyd";
    repo = "mcdex";
    sha256 = "0d5mqvzk9b47kn19cxqbmn8j4792h2yfyj0qpbrksdrwy6a2gg3b";
  };

  vendorSha256 = "sha256-OIJzhQ5cdFizKipjYhTh+rpkAy3OyVgCHMmOdLPPs78=";

  # TODO: add metadata https://nixos.org/nixpkgs/manual/#sec-standard-meta-attributes
  meta = {
    license = lib.licenses.asl20;
    description = "Minecraft Modpack Management";
    longDescription = ''
      mcdex is a command-line utility that runs on Linux, Windows and OSX
      and makes it easy to manage your modpacks while using the native Minecraft launcher.
    '';
  };
}
