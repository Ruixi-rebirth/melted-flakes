{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-esr-102-unwrapped {
      forceWayland = true;
      nixExtensions = [
          (pkgs.fetchFirefoxAddon{
            name = "Adblock Plus";
            url = "https://addons.mozilla.org/firefox/downloads/file/3995494/adblock_plus-3.14.2.xpi";
            sha256 = "sha256-DaatU30g8yf1Ek3E8UNvMvEilokCLlg0H6wJKlZU7g8=";
          })
          (pkgs.fetchFirefoxAddon{
            name = "AdBlock for Firefox";
            url = "https://addons.mozilla.org/firefox/downloads/file/4014431/adblock_for_firefox-5.2.0.xpi";
          })
          (pkgs.fetchFirefoxAddon{
            name = "AdGuard AdBlocker";
            url = "https://addons.mozilla.org/firefox/downloads/file/4012057/adguard_adblocker-4.1.37.xpi";
          })
          (pkgs.fetchFirefoxAddon{
            name = "Content Farm Terminator";
            url = "https://addons.mozilla.org/firefox/downloads/file/4017713/content_farm_terminator-5.9.2.xpi";
          })
          (pkgs.fetchFirefoxAddon{
            name = "Custom New Tab Page";
            url = "https://addons.mozilla.org/firefox/downloads/file/3669474/custom_new_tab_page-1.0.0.xpi";
            sha256 = "sha256-C5GBsK9RYo8cjk8MKL8fNCseDR5d4Fweeqqzu0dPSBQ=";
          })
          (pkgs.fetchFirefoxAddon{
            name = "Enhancer for YouTube";
            url = "https://addons.mozilla.org/firefox/downloads/file/3964540/enhancer_for_youtube-2.0.115.xpi";
            sha256 = "sha256-oHKFhK0rNrEK7J6Ff+xHfLzYT5DlKmB3Hrd/j5jjsdc=";
          })
          (pkgs.fetchFirefoxAddon{
            name = "ImageAssistant Batch Image Downloader";
            url = "https://addons.mozilla.org/firefox/downloads/file/3976583/ia_batch_image_downloader-1.66.6.xpi";
          })
          (pkgs.fetchFirefoxAddon{
            name = "Octotree";
            url = "https://addons.mozilla.org/firefox/downloads/file/3999843/octotree-7.6.1.xpi";
          })
          (pkgs.fetchFirefoxAddon{
            name = "Saladict";
            url = "https://addons.mozilla.org/firefox/downloads/file/3854859/ext_saladict-7.20.0.xpi";
          })
          (pkgs.fetchFirefoxAddon{
            name = "Stylus";
            url = "https://addons.mozilla.org/firefox/downloads/file/3995806/styl_us-1.5.26.xpi";
          })
          (pkgs.fetchFirefoxAddon{
            name = "FireShot";
            url = "https://addons.mozilla.org/firefox/downloads/file/4002435/fireshot-1.11.18.xpi";
          })
          (pkgs.fetchFirefoxAddon{
            name = "Tampermonkey";
            url = "https://addons.mozilla.org/firefox/downloads/file/4009746/tampermonkey-4.18.0.xpi";
          })
          (pkgs.fetchFirefoxAddon{
            name = "Tree Style Tab";
            url = "https://addons.mozilla.org/firefox/downloads/file/4017073/tree_style_tab-3.9.7.xpi";
          })
          (pkgs.fetchFirefoxAddon{
            name = "TST Indent Line";
            url = "https://addons.mozilla.org/firefox/downloads/file/4003179/tst_indent_line-1.2.1.xpi";
          })
          (pkgs.fetchFirefoxAddon{
            name = "TST Mouse Wheel and Double Click";
            url = "https://addons.mozilla.org/firefox/downloads/file/3473925/tree_style_tab_mouse_wheel-1.5.xpi";
          })
          (pkgs.fetchFirefoxAddon{
            name = "TWP";
            url = "https://addons.mozilla.org/firefox/downloads/file/4011167/traduzir_paginas_web-9.6.1.xpi";
          })
          (pkgs.fetchFirefoxAddon{
            name = "uBlacklist";
            url = "https://addons.mozilla.org/firefox/downloads/file/4003811/ublacklist-8.0.2.xpi";
          })
          (pkgs.fetchFirefoxAddon{
            name = "uBlock Origin";
            url = "https://addons.mozilla.org/firefox/downloads/file/4003969/ublock_origin-1.44.4.xpi";
          })
          (pkgs.fetchFirefoxAddon{
            name = "User-Agent Switcher and Manager";
            url = "https://addons.mozilla.org/firefox/downloads/file/3952467/user_agent_string_switcher-0.4.8.xpi";
          })
          (pkgs.fetchFirefoxAddon{
            name = "Vim Vixen";
            url = "https://addons.mozilla.org/firefox/downloads/file/3845233/vim_vixen-1.2.3.xpi";
          })
        ];
      extraPolicies = {
        DisplayBookmarksToolbar = false;    
        Preferences = {
          "browser.toolbars.bookmarks.visibility" = "never";
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "media.ffmpeg.vaapi.enabled" = true;
          "browser.startup.homepage" = "file://${./homepage/index.html}";
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
