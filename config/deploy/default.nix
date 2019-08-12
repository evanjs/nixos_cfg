{ label, host-ips }:

let

  nixosConfig = builtins.toFile "configuration.nix" ''
    builtins.trace "This machine is managed by NixOps, using dummy configuration file for evaluation" {
      fileSystems."/".device = "/dev/sda1";
      boot.loader.grub.device = "nodev";

      assertions = [{
        assertion = false;
        message = "Not gonna do that for you, this is a nixops managed machine";
      }];
    }
  '';

  deployer = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.nixopsUnstable ];

    environment.shellAliases = {
      rb = toString ./rb;
      cachix-use = "cachix use -n -d ${toString ../config}";
    };

    environment.variables = {
      NIXOPS_STATE = toString ../external/private/deployments.nixops;
      NIXOPS_DEPLOYMENT = "evanjs";
    };
  };

in
{
  network = {
    description = "evanjs' machines";
    enableRollback = true;
  };

  defaults = { name, lib, ... }: {
    deployment.targetHost = host-ips.${name} or "${name}.invalid";
    system.nixos.label = label;
    imports = [
      ../config
      ../external/private
      ../external/home-manager/nixos
    ];

    environment.etc.nixpkgs.source = lib.cleanSource (toString ../external/nixpkgs);

    nix.nixPath = [
      "nixos-config=${nixosConfig}"
      "nixpkgs=/etc/nixpkgs"
    ];
  };

  work = {
    imports = [
      ../config/machines/work
      ../external/private/machines/work.nix
    ];
  };

  asus_laptop = {
    deployment.hasFastConnection = true;
    imports = [
      ../config/machines/asus_laptop
      ../external/private/machines/asus_laptop.nix
      deployer
    ];
  };

  rig = {
    imports = [
      ../config/machines/rig
      ../external/private/machines/rig.nix
      deployer
    ];
  };
}
