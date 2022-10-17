{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      forceWayland = true;
      ExtensionSettings = [
        (fetchFirefoxAddon {
          name = "catppuccin-frappe-pink";
        url =
          "https://github.com/catppuccin/firefox/releases/download/old/catppuccin_frappe_pink.xpi";
          sha256 = "UMkjWqNUzk72ZlP1roh1e4xlUpfDYrkKidRTIfAem9M=";
        })
      ];
      extraPolicies = {
        DisplayBookmarksToolbar = false;    
        Preferences = {
          "browser.toolbars.bookmarks.visibility" = "never";
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
      };
    };
    profiles.default = {
       userChrome = builtins.readFile ./userChrome.css;
       userContent = builtins.readFile ./userContent.css;
    };
  };
}
