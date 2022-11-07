{ config, pkgs, lib, ... }:
{
  config = lib.mkIf (config.xsession.enable) {
    services.picom = {
      enable = true;
      package = pkgs.picom;
      extraArgs = [ "--experimental-backends" ];
      settings = {
        # base
        backend = "glx";
        mark-wmwin-focused = true;
        mark-ovredir-focused = true;
        detect-client-opacity = true;
        unredir-if-possible = true;
        vsync = true;
        dbe = false;
        detect-transient = true;
        detect-client-leader = true;
        invert-color-include = [ ];
        glx-copy-from-front = false;
        #round corner
        corner-radius = 0;
        round-borders = 0;
        rounded-corners-exclude = [
          # "class_g *= 'bspwm'"
          "class_g *= 'fcitx'"
          "class_g *= 'Polybar'"
          "class_g *= 'polybar'"
          # "class_g *= 'tray'"
        ];
        #shadow
        shadow = false;
        detect-rounded-corners = false;
        shadow-radius = 4;
        shadow-offset-x = 0;
        shadow-offset-y = 0;
        shadow-opacity = 0.25;
        shadow-ignore-shaped = false;
        shadow-exclude = [
          "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
          "_GTK_FRAME_EXTENTS@:c"
          "override_redirect = 1 && !WM_CLASS@:s"
          "name = 'Notification'"
          "class_g ?= 'Dmenu'"
          "class_g *= 'bspwm'"
          "class_g *= 'Wine'"
          "name = 'Dunst'"
          "class_g *= 'float'"
        ];

        # opacity
        active-opacity = 0.93;
        opacity-rule = [
          "100:_NET_WM_STATE@:32a *= '_NET_WM_STATE_FULLSCREEN'"
          "100:_NET_WM_STATE@:32a *= '_NET_WM_STATE_STICKY'"
          "100:WM_CLASS@:s *= 'vncviewer'"
          "100:class_g = 'mpv'"
          "100:class_g = 'obs'"
          "100:class_g = 'Gimp'"
          "100:class_g = 'firefox'"
          "100:class_g = 'tray'"
          "100:name = 'Polybar tray window'"
          "85:!focused"
        ];

        # fading
        fading = true;
        fade-delta = 2;
        fade-in-step = 0.01;
        fade-out-step = 0.01;
        fade-exclude = [
          "class_g *= 'fcitx'"
          "class_g = 'Rofi'"
          "WM_CLASS@:s *= 'screenkey'"
        ];

        # animations
        animations = true;
        animation-window-mass = 0.5;
        animation-dampening = 16;
        animation-stiffness-in-tag = 125;
        animation-for-open-window = "zoom";
        animation-for-unmap-window = "squeeze";
        animation-exclude = [
          "class_g = 'fcitx'"
          "class_g = 'flameshot'"
          "class_g = 'Dunst'"
          "class_g = 'Rofi'"
          "WM_CLASS@:s *= 'screenkey'"
        ];

        # blur
        blur-method = "dual_kawase";
        blur-strength = 3;
        blur-kern = "3x3box";
        blur-background-exclude = [
          # "class_g *= 'dwm'",
          "window_type = 'dock'"
          "window_type = 'desktop'"
          "_GTK_FRAME_EXTENTS@:c"
          "name *? = 'Sunflower'"
          "class_g *= 'wemeetapp'"
        ];
        wintypes =
          {
            tooltip = { fade = true; shadow = false; opacity = 0.85; focus = true; };
            fullscreen = { fade = true; shadow = false; focus = true; opacity = 0.93; };
          };
      };
    };
  };
}
