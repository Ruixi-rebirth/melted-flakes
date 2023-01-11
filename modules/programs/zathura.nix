{ lib, pkgs, user, ... }:

{
  programs.zathura = {
    enable = true;
    extraConfig = ''
      # Zathura configuration file
      # See man `man zathurarc'

      # Open document in fit-width mode by default
      set adjust-open "best-fit"

      # One page per row by default
      set pages-per-row 1

      #stop at page boundries
      set scroll-page-aware "true"
      set scroll-full-overlap 0.01
      set scroll-step 100

      #zoom settings
      set zoom-min 10
      set guioptions ""

      # zathurarc-dark

      set font "DaddyTimeMono Nerd Font 15"
      set default-fg 			"#96CDFB"
      set default-bg 			"#1A1823"

      set completion-bg		"#1A1823"
      set completion-fg		"#96cdfb"
      set completion-highlight-bg	"#302D41"
      set completion-highlight-fg	"#96cdfb"
      set completion-group-bg		"#1a1823"
      set completion-group-fg		"#89DCEB"

      set statusbar-fg		"#C9CBFF"
      set statusbar-bg		"#1A1823"
      set statusbar-h-padding		10
      set statusbar-v-padding		10

      set notification-bg		"#1A1823"
      set notification-fg		"#D9E0EE"
      set notification-error-bg	"#d9e0ee"
      set notification-error-fg	"#D9E0EE"
      set notification-warning-bg	"#FAE3B0"
      set notification-warning-fg	"#D9E0EE"
      set selection-notification	"true"

      set inputbar-fg			"#C9CBFF"
      set inputbar-bg 		"#1A1823"

      set recolor			"true"
      set recolor-lightcolor		"#D9E0EE"
      set recolor-darkcolor		"#1A1823"

      set index-fg			"#96cdfb"
      set index-bg			"#1A1823"
      set index-active-fg		"#96cdfb"
      set index-active-bg		"#1A1823"

      set render-loading-bg		"#1A1823"
      set render-loading-fg		"#96cdfb"

      set highlight-color		"#96cdfb"
      set highlight-active-color	"#DDB6F2"


      set render-loading "false"
      set scroll-step 50

      set selection-clipboard clipboard
    '';
  };
}
