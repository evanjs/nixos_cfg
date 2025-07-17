{ config, ... }:
{
  imports = [
    # TODO: only enable if the device has a battery
    #   e.g. laptops. _Maybe_ also when a UPC is connected? 
    #./power-warn.nix
    ./random-background.nix
  ];
}
