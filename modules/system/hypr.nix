{
  hyprland,
  pkgs,
  noctalia,
  ...
}:
{
  environment.systemPackages = [
    noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
  
  programs.hyprland = {
    enable = true;
    package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
