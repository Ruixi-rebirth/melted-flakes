{ config, pkgs, lib, inputs, user, ... }:

{
  home.sessionVariables = {
    GTK_THEME = "Nordic";
  };
  home.pointerCursor = {
    package = pkgs.pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
    size = 16;
    x11.enable = true;
  };
  home.pointerCursor.gtk.enable = true;
  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    cursorTheme = {
      name = "Vanilla-DMZ";
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
    };
    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';
  };
}
