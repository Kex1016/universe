{ config, ... }:
{
  imports = [ ./hardware.nix ];

  fileSystems."/nas/m" = {
    device = "192.168.1.5:/volume1/docker/media/jelly/mus";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "noauto"
    ];
  };

  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
      options = "";
    };
  };

  environment.variables = {
    XKB_DEFAULT_LAYOUT = config.services.xserver.xkb.layout;
    XKB_DEFAULT_VARIANT = config.services.xserver.xkb.variant;
    XKB_DEFAULT_OPTIONS = config.services.xserver.xkb.options;
  };

  console.useXkbConfig = true;

  networking.hostName = "coven";
}
