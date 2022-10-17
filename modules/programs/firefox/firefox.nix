{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      forceWayland = true;
      extraPolicies = {
        ExtensionSettings = [];
      };
      extraPolicies = {
        DisplayBookmarksToolbar = false;    
        Preferences = {
          "browser.toolbars.bookmarks.visibility" = "never";
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
      };
    };
    profiles = {
       userChrome = builtins.readFile ./userChrome.css;
       userContent = builtins.readFile ./userContent.css;
    };
  };
}
