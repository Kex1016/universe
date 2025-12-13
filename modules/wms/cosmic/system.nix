{ ... }:
{
  imports = [
    ../generic/system/ananicy.nix
    ../generic/system/boot.nix
    ../generic/system/fonts.nix
    ../generic/system/gaming.nix
    ../generic/system/updater.nix
    ./system/login.nix
    ./system/wm.nix
  ];
}
