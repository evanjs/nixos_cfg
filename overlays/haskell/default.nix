{
  imports = (
    if builtins.pathExists(./module.nix) then [ ./module.nix ]
    else []
    );

    nixpkgs.overlays = [
      (import ./overlay.nix)
    ];
  }
