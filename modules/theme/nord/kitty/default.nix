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
        # Nord Colorscheme for Kitty
        # Based on:
        # - https://gist.github.com/marcusramberg/64010234c95a93d953e8c79fdaf94192
        # - https://github.com/arcticicestudio/nord-hyper

        foreground            #D8DEE9
        background            #434c5e
        selection_foreground  #000000
        selection_background  #FFFACD
        url_color             #0087BD
        cursor                #81A1C1

        # black
        color0   #3B4252
        color8   #4C566A

        # red
        color1   #BF616A
        color9   #BF616A

        # green
        color2   #A3BE8C
        color10  #A3BE8C

        # yellow
        color3   #EBCB8B
        color11  #EBCB8B

        # blue
        color4  #81A1C1
        color12 #81A1C1

        # magenta
        color5   #B48EAD
        color13  #B48EAD

        # cyan
        color6   #88C0D0
        color14  #8FBCBB

        # white
        color7   #E5E9F0
        color15  #ECEFF4
      '';
    };
  };
}
