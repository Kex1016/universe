{ config, ... }:
{
  programs = {
    swayimg = {
      enable = true;
      settings = {
        general = {
          overlay = "yes";
        };
        "keys.viewer" = {
          "Y" = ''exec ${config.home.homeDirectory}/.local/bin/hyprimgcpy "%"'';
        };
      };
    };
  };
}
