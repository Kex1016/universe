{ config, pkgs-unstable, lib, ... }:

{
  home.packages = with pkgs-unstable; [ equibop ];
}
