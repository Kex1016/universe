{ ... }:
{
  imports = [
    ../../shells/fish.nix
    ../generic/home/kitty.nix
    ../generic/home/symlinks.nix
    ../generic/home/userDirs.nix
    ./home/catppuccin.nix
    ./home/noctalia.nix
    ./home/wm.nix
  ];
}
