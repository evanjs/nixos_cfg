{ lib, pkgs, config, ... }:
with lib;

let cfg = config.mine.rocm;

in {
  options.mine.rocm = {
    enable = mkEnableOption "Radeon Open Compute (2.10.0) packages for NixOS";

    targets = mkOption {
      type = types.nullOr (types.listOf types.str);
      default = null;
      example = [ "gfx803" "gfx900" "gfx906" ];
      description = "The GPU compilation targets.";
    };

  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [ (import "${(import ../nix/sources.nix {}).nixos-rocm}") ];

    hardware.opengl.enable = true;
    hardware.opengl.extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];

    systemd.tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];

    nixpkgs.config.rocmTargets = lib.optional cfg.targets;

    users.users = genAttrs config.mine.mainUsers (name: {
      extraGroups = [ "video" ];
    });

    nix.sandboxPaths = [
      "/dev/kfd"
      "/sys/devices/virtual/kfd"
      "/dev/dri/renderD128"
    ];

  };
}
