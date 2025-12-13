{ pkgs, config, ... }:
{
  imports = [ ];

  home.packages = with pkgs; [
    zathura
    pavucontrol
    gnome-font-viewer
    qpwgraph
    inotify-tools
    gapless
    file
    jetbrains.idea-community-bin
  ];

  programs = {
    swayimg = {
      enable = true;
      settings = {
        general = {
          overlay = "yes";
        };
        viewer = {
          window = "#1e1e2eff";
        };
        "keys.viewer" = {
          "Y" = ''exec ${config.home.homeDirectory}/.local/bin/hyprimgcpy "%"'';
        };
      };
    };
    zathura = {
      enable = true;
    };
  };
}
