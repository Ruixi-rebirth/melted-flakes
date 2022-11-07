{ config, pkgs, ... }:

{
  programs = {
    kitty = {
      font.name = "jetbrains mono nerd font";
      font.size = 15;
      settings = {
        italic_font = "auto";
        bold_italic_font = "auto";
        mouse_hide_wait = 2;
        cursor_shape = "block";
        url_color = "#0087bd";
        url_style = "dotted";
        #Close the terminal =  without confirmation;
        confirm_os_window_close = 0;
        background_opacity = "0.95";
      };
      extraConfig = ''
        foreground              #4C4F69
        background              #EFF1F5
        selection_foreground    #EFF1F5
        selection_background    #DC8A78

        # Cursor colors
        cursor                  #DC8A78
        cursor_text_color       #EFF1F5

        # URL underline color when hovering with mouse
        url_color               #DC8A78

        # Kitty window border colors
        active_border_color     #7287FD
        inactive_border_color   #9CA0B0
        bell_border_color       #DF8E1D

        # OS Window titlebar colors
        wayland_titlebar_color system
        macos_titlebar_color system

        # Tab bar colors
        active_tab_foreground   #EFF1F5
        active_tab_background   #8839EF
        inactive_tab_foreground #4C4F69
        inactive_tab_background #9CA0B0
        tab_bar_background      #BCC0CC

        # Colors for marks (marked text in the terminal)
        mark1_foreground #EFF1F5
        mark1_background #7287fD
        mark2_foreground #EFF1F5
        mark2_background #8839EF
        mark3_foreground #EFF1F5
        mark3_background #209FB5

        # The 16 terminal colors

        # black
        color0 #5C5F77
        color8 #6C6F85

        # red
        color1 #D20F39
        color9 #D20F39

        # green
        color2  #40A02B
        color10 #40A02B

        # yellow
        color3  #DF8E1D
        color11 #DF8E1D

        # blue
        color4  #8378c6
        color12 #8378c6

        # magenta
        color5  #EA76CB
        color13 #EA76CB

        # cyan
        color6  #179299
        color14 #179299

        # white
        color7  #ACB0BE
        color15 #BCC0CC
      '';
    };
  };
}
