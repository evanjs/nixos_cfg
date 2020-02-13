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
      security.wrappers.spice-client-glib-usb-acl-helper.source = "${pkgs.spice-gtk}/bin/spice-client-glib-usb-acl-helper";
      environment.systemPackages = with pkgs; [ spice-gtk virt-manager ];
      security.polkit.enable = true;
      users.users.evanjs.extraGroups = [ "libvirtd" "qemu-libvirtd" ];
      virtualisation.libvirtd = {
        enable = true;
        qemuOvmf = true;
      };
    };
  }
