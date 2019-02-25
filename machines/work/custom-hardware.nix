{ config, ... }:
{
  imports = [
    ../../hardware/cpu/intel.nix
    ../../hardware/gpu/intel.nix
    ../../hardware/profiles/wireless.nix
}
