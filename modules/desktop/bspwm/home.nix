{ config, lib, pkgs, ... }:

{
  imports = [
    (import ../../environment/bspwm-variables.nix)
  ];
  xsession = {
    enable = true;
    numlock.enable = true;
    windowManager.bspwm = {
      enable = true;
      alwaysResetDesktops = true;
      startupPrograms = [
        "sxhkd"
        "default_wall"
        "flameshot"
        "dunst"
        "nm-applet --indicator"
        "sleep 2s;polybar -q main"
      ];
      monitors = {
        eDP-2 = [
          "I"
          "II"
          "III"
          "IV"
          "V"
        ];
      };
      rules = {
        "mpv" = {
          state = "floating";
          center = true;
        };
        "termfloat" = {
          state = "floating";
          center = true;
        };
        "nemo" = {
          state = "floating";
          center = true;
        };
      };
      settings = {
        pointer_modifier = "mod1";
        # top_padding = 40;
        border_width = 3;
        window_gap = 8;
        split_ratio = 0.5;
        borderless_monocle = false;
        gapless_monocle = false;
        focus_follows_pointer = false;
        normal_border_color = "#434c5e";
        focused_border_color = "#81A1C1";
        urgent_border_color = "#88C0D0";
        presel_border_color = "#8FBCBB";
        presel_feedback_color = "#B48EAD";
      };
      extraConfig = ''
      '';
      extraConfigEarly = ''
        systemctl --user start bspwm-session.target 
        systemctl --user start tray.target
      '';
    };
  };
  systemd.user.targets.bspwm-session = {
    Unit = {
      Description = "bspwm session";
      BindsTo = [ "graphical-session.target" ];
      Wants = [ "graphical-session-pre.target" "xdg-desktop-autostart.target" ];
      After = [ "graphical-session-pre.target" ];
    };
  };
  programs = {
    bash = {
      initExtra = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
           exec  startx
        fi
      '';
    };
    fish = {
      loginShellInit = ''
        if status --is-login
            if test -z "$DISPLAY" -a $XDG_VTNR = 1
                exec startx
            end
        end
      '';
    };
  };
  home.file = {
    ".xinitrc".text = ''
      if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval $(dbus-launch --exit-with-session --sh-syntax)
      fi
      systemctl --user import-environment DISPLAY XAUTHORITY
      if command -v dbus-update-activation-environment >/dev/null 2>&1; then
       dbus-update-activation-environment DISPLAY XAUTHORITY
      fi
       ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
         Xcursor.theme: Catppuccin-Frappe-Dark
        ''}
      exec bspwm 
    '';
  };
}
