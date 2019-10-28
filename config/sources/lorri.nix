{ fetchFromGitHub }:
let
  res = fetchFromGitHub {
    owner = "target";
    repo = "lorri";
    rev = "da0e72da2f56cd5013cca468dc5f2d774bbd8f9e";
    sha256 = "053xn53z1yg7qihh6zq4ibycd7j4dxay1ihrcjj7bww4ghxjwja2";
  };
in res // {
  meta = res.meta // {
    branch = "rolling-release";
  };
}
