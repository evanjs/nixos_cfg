{ config, pkgs, ... }:
{
  # Configuration relevant to more than one development language/environment
  mine.userConfig = {
    home.packages = [ pkgs.universal-ctags ];
  };
}
