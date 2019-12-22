{ config, lib, ... }:

with lib;

{
  options.mine.mosh.enable = mkOption {
    type = types.bool;
    default = true;
    description = "mosh";
  };

  config = mkIf config.mine.mosh.enable {
    programs.mosh.enable = true;
  };
}
