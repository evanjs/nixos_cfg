# flake.nix
{
  description = "Alienware desktop - minimal Plasma";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #disko.url = "github:nix-community/disko";
    #disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, disko, home-manager, flake-parts, nixvim }:
  #let
    #system = "x86_64-linux";
      ##pkgs = import nixpkgs { inherit system; config.allowUnfree = true;};
  #in {
  {
    #flake-parts.lib.mkFlake { inherit inputs; } {
      #imports = [
      ## Import home-manager's flake module
      #inputs.home-manager.flakeModules.home-manager
      #];
      #systems = inputs.nixpkgs.lib.systems.flakeExposed;

      #flake ={
  nixosConfigurations.alienix = nixpkgs.lib.nixosSystem {
  #pkgs = import nixpkgs { inherit system; config.allowUnfree = true;};
  specialArgs = { inherit inputs; };
  system = "x86_64-linux";
  modules = [
    home-manager.nixosModules.home-manager
    #          disko.nixosModules.disko
    #./hardware-configuration.nix
    config/machines/alienix
    #{
      #nix.nixPath = [
        #"nixpkgs=${nixpkgs}"
      #];
      #nix.registry.nixpkgs.flake = nixpkgs;
          #system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
        #}
      #];
    #}
  ];
  };
};
}
