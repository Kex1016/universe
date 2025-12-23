{ ... }:
{
  imports = [
    ../generic/home/browsers.nix
    ../generic/home/cli.nix
    ../generic/home/editors.nix
    ../generic/home/essentials.nix
    ../generic/home/extras.nix
    ../generic/home/gaming.nix
    ../generic/home/obs-studio.nix
    ../generic/home/vesktop.nix
    ../generic/home/vscode.nix
    ./home/cli.nix
    ./home/essentials.nix
    ./home/nemo.nix
  ];
}
