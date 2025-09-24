{
  config,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.packages = with pkgs; [
    prismlauncher
    pkgs-unstable.r2modman
    pkgs-unstable.lutris
    pkgs-unstable.osu-lazer-bin
    pkgs-unstable.xivlauncher
  ];

  # also see system/gaming.nix
}
