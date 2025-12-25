{ pkgs, ... }:
{
  imports = [
    ../../shells/fish.nix
    ../generic/home/kitty.nix
    ../generic/home/symlinks.nix
    ../generic/home/userDirs.nix
    ./home/noctalia.nix
    ./home/niri.nix
    ./home/xdg.nix
  ];
}
