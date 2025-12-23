{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nautilus
    code-nautilus
    nautilus-open-any-terminal
    file-roller # this is here because its very relevant to the above pkg
  ];
}
