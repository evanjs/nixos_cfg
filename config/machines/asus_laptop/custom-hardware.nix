{ config, ... }:
{
  imports = [
    ../../hardware/gpu/nvidia.nix
    ../../hardware/profiles/wireless.nix
    ../../hardware/display/touchscreen.nix
  ];
}
