{
  ...
}:
{
  imports = [
    ./hardware.nix
    ../../system/gaming.nix
    ../../apps/steam.nix
  ];

  networking.hostName = "balefire";
  networking.wireless.enable = true;
  networking.wireless.userControlled.enable = true;
}
