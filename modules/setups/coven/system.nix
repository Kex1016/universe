{
  ...
}:
{
  imports = [
    ./hardware.nix
    ../../system/gaming.nix
    ../../apps/steam.nix
  ];

  fileSystems."/nas/m" = {
    device = "192.168.1.5:/volume1/docker/media/jelly/mus";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "noauto"
    ];
  };

  networking.hostName = "coven";

  services.ollama = {
    enable = true;
    acceleration = "rocm";
  };

  services.open-webui = {
    enable = true;
    port = 9090;
  };
}
