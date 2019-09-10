{ config, ... }:
{
  imports = [
    ../../hardware/gpu/intel.nix
    ../../hardware/profiles/wireless.nix
  ];
}
