{
  ...
}:

{
  programs.kitty = {
    enable = true;
    settings = {
      cursor_trail = 1;
      shell = "fish";
      ediot = "nvim";
    };
    shellIntegration.enableFishIntegration = true;
  };
}
