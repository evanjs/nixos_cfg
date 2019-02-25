{ config, ... }:
{
  imports = [
    ../../hardware/cpu/intel.nix
    ../../hardware/gpu/nvidia.nix
    ../../hardware/profiles/wireless.nix
}
