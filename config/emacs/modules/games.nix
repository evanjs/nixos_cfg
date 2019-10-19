{ dag, epkgs, pkgs, lib, config, ... }:

with lib;

{

  options.games = mkOption {
    type = types.bool;
    default = false;
    description = "Emacs games and etc";
  };

  config = mkIf config.games {

    packages = with epkgs; [
      _2048-game
    ];
  };
}
