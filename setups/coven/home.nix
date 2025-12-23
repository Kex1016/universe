{ ... }:
{
  # > Niri
  programs.niri = {
    settings = {
      spawn-at-startup = [
        {
          command = [
            "steam"
            "-silent"
          ];
        }
      ];

      input = {
        keyboard.xkb = {
          layout = "us";
        };
      };
    };
  };

  # > Fish
  programs.fish = {
    shellAliases = {
      sacrifice = "cd $HOME/.nixos/universe && git pull && sudo nixos-rebuild switch --flake $HOME/.nixos/universe#coven";
    };
  };
}
