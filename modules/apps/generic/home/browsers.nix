{
  pkgs,
  ffaddons,
  zen-browser,
  ...
}:

{
  home.packages = with pkgs; [
    vivaldi
    vivaldi-ffmpeg-codecs
    firefoxpwa
  ];

  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = [ pkgs.firefoxpwa ];
    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };
    profiles.default.settings = {
      browser = {
        tabs.warnOnClose = false;
      };
    };
    profiles.default.extensions.packages = with ffaddons; [
      adnauseam
      keepassxc-browser
      tampermonkey
      stylus
      shinigami-eyes
      augmented-steam
      sponsorblock
      karakeep
      enhanced-github
      github-file-icons
      consent-o-matic
      decentraleyes
      clearurls
      canvasblocker
      indie-wiki-buddy
      seventv
      themesong-for-youtube-music
      improved-tube
      redirect-shorts-to-youtube
      return-youtube-dislikes
    ];
    profiles.default.search = {
      force = true; # Needed for nix to overwrite search settings on rebuild
      default = "ddg"; # Aliased to duckduckgo, see other aliases in the link above
      engines = {
        # My nixos Option and package search shortcut
        mynixos = {
          name = "My NixOS";
          urls = [
            {
              template = "https://mynixos.com/search?q={searchTerms}";
              params = [
                {
                  name = "query";
                  value = "searchTerms";
                }
              ];
            }
          ];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@nx" ]; # Keep in mind that aliases defined here only work if they start with "@"
        };
      };
    };
  };

  stylix.targets.zen-browser.profileNames = [ "default" ];

  xdg.mimeApps =
    let
      value =
        let
          zen = zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.beta;
        in
        zen.meta.desktopFileName;

      associations = builtins.listToAttrs (
        map (name: { inherit name value; }) [
          "application/x-extension-shtml"
          "application/x-extension-xhtml"
          "application/x-extension-html"
          "application/x-extension-xht"
          "application/x-extension-htm"
          "x-scheme-handler/unknown"
          "x-scheme-handler/mailto"
          "x-scheme-handler/chrome"
          "x-scheme-handler/about"
          "x-scheme-handler/https"
          "x-scheme-handler/http"
          "application/xhtml+xml"
          "application/json"
          "text/plain"
          "text/html"
        ]
      );
    in
    {
      associations.added = associations;
      defaultApplications = associations;
    };
}
