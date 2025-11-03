{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    zathura
    pavucontrol
    gnome-font-viewer
    qpwgraph
    cider
    spotify
    inotify-tools
    gapless
    file
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
    mpv = {
      enable = true;
    };
  };

  services = {
    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}
