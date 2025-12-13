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
    # FIXME: only generics here for now, you should add some more apps if you need any more
  ];
}
