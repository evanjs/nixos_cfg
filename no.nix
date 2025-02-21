{
  description = "NixOS desktop (work)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nur.url = "github:nix-community/nur/1497e2d00a3dfef017c5ceff1da886b7032e1e6a";
    rjg = {
      url = "git+ssh://git@github.com/rjginc/overlay?submodules=1";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.sekka = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./config/machines/wdesk
      ];
    };
  };
}
