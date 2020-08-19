{ pkgs }:

with pkgs.haskell.lib;

let
  hpkgs = pkgs.haskellPackages;
in

(hpkgs.extend (packageSourceOverrides {
  mytaffybar = ./.;
})).extend (self: super: {
  mytaffybar = super.mytaffybar.overrideAttrs (drv: {
    nativeBuildInputs = drv.nativeBuildInputs or [] ++ [ pkgs.makeWrapper ];
  });
}) // { inherit pkgs; }
