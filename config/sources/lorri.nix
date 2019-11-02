{ fetchFromGitHub }:
let
  res = fetchFromGitHub {
    owner = "target";
    repo = "lorri";
    rev = "03f10395943449b1fc5026d3386ab8c94c520ee3";
    sha256 = "0fcl79ndaziwd8d74mk1lsijz34p2inn64b4b4am3wsyk184brzq";
  };
in res // {
  meta = res.meta // {
    branch = "rolling-release";
  };
}
