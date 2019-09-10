{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    #zeal # uses qtwebkit -- #68434 #53079
  ];
}
