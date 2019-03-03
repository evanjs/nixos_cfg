{ config, pkgs, ...}:
{
  virtualisation = {
    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
      };
    };
    kvmgt.enable = true;
  };
  users.extraUsers.evanjs.extraGroups = ["vboxusers"];
}
