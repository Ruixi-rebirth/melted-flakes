{ config, pkgs, ... }:

{
  programs = {
    kitty = {
      enable = true;
      environment = {};
      settings = {
        italic_font      = "auto";
        bold_italic_font = "auto";
        mouse_hide_wait  = 2;
        cursor_shape     = "block";
        url_color        = "#0087bd";
        url_style        = "dotted";
        #Close the terminal =  without confirmation;
        confirm_os_window_close = 0;
        background_opacity = "0.95";
      };
      theme = "Catppuccin-Mocha";
      keybindings = {};
      font.name = "jetbrains mono nerd font";
      font.size = 15;
    };
  };
}
