{ config, pkgs, lib, ... }:

let
  cfg = config.hyprcap or { inherit (lib) mkOption; enable = false; includeExtras = []; };
in
{
  options.hyprcap = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable hyprcap";
    };
    includeExtras = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Optional extra packages for hyprcap (wl-clipboard, fuzzel, libnotify, hyprpicker, etc.)";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.concatLists [
      [ pkgs.hyprcap ]
      (if cfg.includeExtras == [] then [] else cfg.includeExtras)
    ];
  };
}
