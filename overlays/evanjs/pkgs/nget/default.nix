{ stdenv
, fetchFromGitHub
, rustPlatform
}:
rustPlatform.buildRustPackage rec {
  name = "nget";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "evanjs";
    repo = "nget";
    rev = "5d31d26dd0078b1bdab2f4d39df8c8856e577b8f";
    sha256 = "17vm3b1x3q6yn8d8zff9bwlwwi8c4zp5w06zljaak6kwhqsrgikw";
  };

  cargoSha256 = "146hg5ka3hzz7qf3v9h2nniwm61xv4c8hq9lag95cs2axhb93qdf";
}
