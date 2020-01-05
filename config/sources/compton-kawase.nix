{ pkgs }: let src = pkgs.fetchFromGitHub {
  owner  = "tryone144";
  repo   = "compton";
  rev    = "f92eb6b05aa6bbe5da53cf27d652db2b6771e02c";
  sha256 = "1ijs6qd4f54i40a9k28mynfx7czwb9jfgdq22kv4vjjf1rsbpsyd";
}; in src // {
  meta = src.meta // {
    branch = "feature/dual_kawase";
  };
}
