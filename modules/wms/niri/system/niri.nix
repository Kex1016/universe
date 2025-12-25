{
  pkgs,
  noctalia,
  config,
  ...
}:
{
  environment.systemPackages = [
    noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.xwayland-satellite
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
}
