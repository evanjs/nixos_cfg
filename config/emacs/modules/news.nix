{ dag, epkgs, pkgs, lib, config, ... }:

with lib;

{

  options.news = mkOption {
    type = types.bool;
    default = false;
    description = "News stuff";
  };

  config = mkIf config.news {

    packages = with epkgs; [
      hackernews
    ];

    init.news = ''
      (require 'hackernews)
      (autoload 'hackernews-ask-stories "hackernews" nil t)
    '';

  };

}
