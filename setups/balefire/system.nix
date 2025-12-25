{ config, ... }:
{
  imports = [ ./hardware.nix ];

  services.xserver = {
    xkb = {
      layout = "hu";
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

  networking.hostName = "balefire";
}
