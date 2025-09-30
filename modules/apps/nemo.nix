{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    nemo-with-extensions
    file-roller # this is here because its very relevant to the above pkg
  ];
}
