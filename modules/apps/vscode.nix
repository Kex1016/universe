{ config, pkgs, lib, ... }:

{
  # TODO(?): maybe make this into fully declarative, maybe not.
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
  };
}
