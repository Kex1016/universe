{ ... }:
{
  # > Niri
  programs.niri = {
    settings = {
      input = {
        keyboard.xkb = {
          layout = "hu";
        };
      };
    };
  };

  # > Fish
  programs.fish = {
    shellAliases = {
      sacrifice = "cd $HOME/.nixos/universe && git pull && sudo nixos-rebuild switch --flake $HOME/.nixos/universe#balefire";
    };
  };
}
