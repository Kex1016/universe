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
  ];

  # also see system/gaming.nix
}
