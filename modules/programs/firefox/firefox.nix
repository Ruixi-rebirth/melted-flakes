{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      forceWayland = true;
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
       settings = {
            "browser.startup.homepage" = "";
        };
    };
  };
}
