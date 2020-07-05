{ config, ... }:
{
  imports = [
    ../../hardware/gpu/nvidia.nix
    ../../hardware/profiles/wireless.nix
    ../../hardware/profiles/laptop.nix
  ];

  fileSystems."/data/win" = {
    device = "/dev/disk/by-uuid/520C74190C73F677";
    fsType = "ntfs-3g";
  };
}
