{pkgs, ...}: {
  programs = {
    gamescope = {
      enable = true;
      capSysNice = false;
    };
    gamemode = {
      enable = true;
      enableRenice = false;
      settings = {
        general = {
          renice = 10;
        };

        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };
  };

  # see also apps/gaming.nix
}