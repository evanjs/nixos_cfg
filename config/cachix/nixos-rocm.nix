
{
  nix = {
    settings = {
      substituters = [
        "https://nixos-rocm.cachix.org"
      ];
      trusted-public-keys = [
        "nixos-rocm.cachix.org-1:VEpsf7pRIijjd8csKjFNBGzkBqOmw8H9PRmgAq14LnE="
      ];
    };
  };
}
