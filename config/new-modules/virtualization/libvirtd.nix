{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.mine.virtualization.libvirtd;
in
{
  options.mine.virtualization.libvirtd = {
    enable = mkEnableOption "Libvirtd support";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ spice-gtk virt-manager ];
    security.polkit.enable = true;
    users.users.evanjs.extraGroups = [ "libvirtd" "qemu-libvirtd" "usb" ];
    users.groups.usb = { };
    services = {
      qemuGuest = {
        enable = true;
      };
      udev.extraRules = ''
        KERNEL=="*", SUBSYSTEMS=="usb", MODE="0664", GROUP="usb"
      '';
    };

    virtualisation.libvirtd = {
      enable = true;
      qemuOvmf = true;
    };

  };
}
