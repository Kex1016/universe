{ config, ... }:
{
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
  };
}
