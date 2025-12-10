{ ... }:
{
  imports = [
    ./hardware.nix
    ../../system/gaming.nix
    ../../apps/steam.nix
  ];

  networking.hostName = "balefire";
}
