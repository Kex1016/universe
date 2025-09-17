{
  lib,
  stdenv,
  fetchFromGitHub,
  pkgs,
  ...
}:

final: prev: rec {
  hyprcap = prev.stdenv.mkDerivation {
    pname = "hyprcap";
    version = "1.3.0"; # adjust to tag you want

    src = prev.fetchFromGitHub {
      owner = "alonso-herreros";
      repo = "hyprcap";
      rev = "v${version}";
      sha256 = "ac5379b4b19a1672abe857f5b32655b7b51866bd";
    };

    propagatedBuildInputs = with prev; [
      wf-recorder
      grim
      slurp
      hyprland
      jq
    ];

    installPhase = ''
      mkdir -p $out/bin
      cp ${src}/hyprcap $out/bin/hyprcap
      chmod +x $out/bin/hyprcap
    '';

    meta = with prev.lib; {
      description = "hyprcap: capture screenshots / recordings in Hyprland";
      homepage = "https://github.com/alonso-herreros/hyprcap";
      license = licenses.gpl3Only;
      platforms = platforms.linux;
    };
  };
}
