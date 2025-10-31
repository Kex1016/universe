# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  pkgs,
  pkgs-unstable,
  ...
}:

{
  imports = [
    ./modules/system/hypr.nix
    ./modules/system/fonts.nix
    ./modules/system/ananicy.nix
  ];

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "flamingo";
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  networking.firewall = rec {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
    allowedTCPPorts = [ 22 80 443 5900 ];
  };
  
  time.timeZone = "Europe/Budapest";

  # Enable the X11 windowing system. lol, lmao.
  # services.xserver.enable = true;

  services.displayManager.ly = {
    enable = true;
  };
  services.printing.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.sudo.extraConfig = ''
    Defaults pwfeedback
  '';

  hardware.i2c.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  environment.systemPackages = [
    pkgs.distrobox
    pkgs-unstable.distroshelf
  ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.majo = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "i2c"
    ]; # Enable ‘sudo’ for the user.
  };

  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.05"; # Did you read the comment?

}
