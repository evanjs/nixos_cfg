{ stdenv, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  name = "bingrep";
  version = "unstable-2019-07-01";

  src = fetchFromGitHub {
    owner = "m4b";
    repo = "bingrep";
    rev = "33d56a4b020c4a3c111294fe41c613d5e8e9c7af";
    sha256 = "0lg92wqknr584b44i5v4f97js56j89z7n8p2zpm8j1pfhjmgcigs";
  };

  cargoSha256 = "01qbz4j03rf0yrjilbxih2g4i3pa49qccah899z35qbjvy4arv1v";
}
