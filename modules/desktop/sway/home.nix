{ config, lib, pkgs, ... }:

{
  imports = [ ../../environment/sway-variables.nix ];
  programs = {
    bash = {
      initExtra = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
           exec sway
        fi
      '';
    };
    fish = {
      loginShellInit = ''
        set TTY1 (tty)
        [ "$TTY1" = "/dev/tty1" ] && exec sway --unsupported-gpu
      '';
    };
  };
  systemd.user = {
    targets.sway-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  };
  home = {
    packages = with pkgs; [
      swaybg
      swayidle
      swaylock-effects
      pamixer
    ];
  };
  wayland.windowManager.sway = {
    enable = true;
    extraOptions = [ "--unsupported-gpu" ];
    wrapperFeatures.gtk = true;
    config = null;
    extraConfig = ''
      #---------p
      # mod key #
      #---------#
          set $mod Mod1

      #---------------#
      # waybar toggle #
      #---------------#
          bindsym $mod+o exec killall -SIGUSR1 .waybar-wrapped

      #-------------------------------------------#
      # switch between current and last workspace #
      #-------------------------------------------#
      #slash(/)
          bindsym $mod+slash workspace back_and_forth

      #-------------------------------#
      # Switch to prev/next workspace #
      #-------------------------------#
      #comma(,) period(.)
      bindsym $mod+period workspace next
      bindsym $mod+comma workspace prev

      #-----------------------------#
      #           Misc              #
      #-----------------------------#
      output * adaptive_sync on

      default_border pixel 3
      default_floating_border pixel 3
      gaps inner  5
      gaps outer  0
      bindsym $mod+shift+g exec swaymsg gaps outer all set 0 && swaymsg gaps inner all set 5 
      bindsym $mod+g exec swaymsg gaps outer all set 0 && swaymsg gaps inner all set 0

      # Activate smart borders (always)
      smart_borders on
      #smart_gaps on

      #------------------------------#
      # Always float certain windows #
      #------------------------------#
      #swaymsg -t get_tree | grep app_id
          for_window [app_id="pop-up"]                     floating enable
          for_window [app_id="bubble"]                     floating enable 
          for_window [app_id="task_dialog"]                floating enable
          for_window [app_id="Preferences"]                floating enable
          for_window [app_id="dialog"]                     floating enable 
          for_window [app_id="menu"]                       floating enable
          for_window [app_id="Organizer"]                  floating enable
          for_window [app_id="About"]                      floating enable
          for_window [app_id="toolbox"]                    floating enable
          for_window [app_id="page-info"]                  floating enable	
          for_window [app_id="webconsole"]                 floating enable
          for_window [app_id="Authy"]                      floating enable
          for_window [app_id="termfloat"]                  floating enable
          for_window [app_id="termfloat"]                  resize set height 540
          for_window [app_id="termfloat"]                  resize set width 960
          for_window [app_id="mpv"]                        floating enable 
          for_window [app_id="mpv"]                        resize set height 540
          for_window [app_id="mpv"]                        resize set width 960
          for_window [app_id="nemo"]                   floating enable 
          for_window [app_id="nemo"]                   resize set height 540
          for_window [app_id="nemo"]                   resize set width 960

      #-------------------------------------------------------#
      # Sticky floating windows(sticky enable|disable|toggle) #
      #-------------------------------------------------------#
          for_window [app_id="danmufloat"]                  floating enable
          for_window [app_id="danmufloat"]                  sticky enable 
          for_window [app_id="danmufloat"]                  resize set height 540
          for_window [app_id="danmufloat"]                  resize set width 960

      #-----------------#
      # Program Opacity #
      #-----------------#
          for_window [app_id="telegram"]                    opacity 0.95
          for_window [app_id="danmufloat"]                    opacity 0.80
          for_window [app_id="icalingua"]                   opacity 0.95
          for_window [class="netease-cloud-music-gtk4"]          opacity 0.90

      #------------------------------------------#
      # Placing software in a specific workspace #
      #------------------------------------------#
          #assign [app_id="telegram"]: workspace num  ber 10
          for_window [app_id="icalingua"] move --no-auto-back-and-forth container to workspace QQ
          for_window [app_id="icalingua"] focus
          for_window [app_id="telegram"] move --no-auto-back-and-forth container to workspace TG
          for_window [app_id="telegram"] focus
          for_window [class="netease-cloud-music"] move --no-auto-back-and-forth container to workspace 网易云
          for_window [class="netease-cloud-music"] focus

      #---------------------#
      # Focus follows mouse #
      #---------------------#
          focus_follows_mouse no

      #-----------#
      # Autostart #
      #-----------#
          exec_always  --no-startup-id  launch_waybar &
          exec_always  --no-startup-id  mako &
          exec_always  --no-startup-id  nm-applet --indicator &

      #-------------------------------#
      # Make capslock work as escape #
      #-------------------------------#
          input "type:keyboard" {           
              xkb_layout us
              xkb_options caps:escape
          }

      #----------------------------------------#
      # window colours: border background text #
      #----------------------------------------#
          client.focused          #ffc0cb #ffc0cb #ffffff
          client.unfocused        #2e3440 #1f222d #888888
          client.focused_inactive #2e3440 #1f222d #888888 
          client.placeholder      #2e3440 #1f222d #888888
          client.urgent           #D08770 #D08770 #ffffff
          client.background       #242424

      #-----------------------------------#
      # Home row direction keys, like vim #
      #-----------------------------------#
          set $left  h
          set $down  j
          set $up    k
          set $right l

      #----------------------------------#
      # Your preferred terminal emulator #
      #----------------------------------#
          set $term kitty
        
      #-------------------------------------#
      # Your preferred application launcher #
      #-------------------------------------#
          # Note: pass the final command to swaymsg so that the resulting window can be opened
          # on the original workspace that the command was run on.
          # set $menu dmenu_path | dmenu | xargs swaymsg exec --

      #-----------#
      # WallPaper #
      #-----------#
          ### Output configuration
          #
          # Default wallpaper (more resolutions are available in /usr/share/backgrounds/sway/)
          #output * bg /usr/share/backgrounds/sway/Sway_Wallpaper_Blue_1920x1080.png fill
          #
          # Example configuration:
          #
          #   output HDMI-A-1 resolution 1920x1080 position 1920,0
          #
          # You can get the names of your outputs by running: swaymsg -t get_outputs
          # exec_always --no-startup-id swaybg -i ~/.config/sway/wallpaper/02.png 
          # Automatically change wallpapers at intervals
          exec_always --no-startup-id default_wall & 

      #-------------------------------------------------#
      # Control volume,monitor brightness,media players #
      #-------------------------------------------------#
          bindsym XF86AudioRaiseVolume exec pamixer -i 5
          bindsym XF86AudioLowerVolume exec pamixer -d 5
          bindsym XF86AudioMute exec pamixer -t
          bindsym XF86AudioMicMute exec pamixer --default-source -t
          bindsym XF86MonBrightnessUp exec light -A 5
          bindsym XF86MonBrightnessDown exec light -U 5
          bindsym XF86AudioPlay exec playerctl play-pause
          bindsym XF86AudioNext exec playerctl next
          bindsym XF86AudioPrev exec playerctl previous

      #--------------------#
      # Idle configuration #
      #--------------------#
          #exec swayidle -w \
                  #timeout 300 '~/.config/sway/swaylock.sh' \
                  #timeout 600 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' \
                  #timeout 6 'systemctl suspend' \
                  #before-sleep '~/.config/sway/swaylock.sh'

          exec swayidle -w \
                 timeout 900 'systemctl suspend' \
                  before-sleep 'myswaylock'


      # This will lock your screen after 300 seconds of inactivity, then turn off
      # your displays after another 300 seconds, and turn your screens back on when
      # resumed. It will also lock your screen before your computer goes to sleep.

      #---------------------#
      # Input configuration #
      #---------------------#
          # You can get the names of your inputs by running: swaymsg -t get_inputs
          # Read `man 5 sway-input` for more information about this section.
          input "1739:52781:MSFT0001:01_06CB:CE2D_Touchpad" {
                 dwt enabled
                 tap enabled
                 natural_scroll enabled
                 middle_emulation enabled
             }


      #----------------#
      # Key bindings --#
      #----------------#
          # Start a terminal
          bindsym $mod+Return exec $term
          bindsym $mod+Shift+Return exec kitty --class="termfloat"


          # quick start some applications
          bindsym $mod+m exec --no-startup-id              netease-cloud-music-gtk4
          bindsym $mod+b exec --no-startup-id              nvidia-offload firefox
          bindsym $mod+Shift+d exec kitty --class="danmufloat" --hold sh -c "export TERM=xterm-256color && bili" 
          bindsym $mod+Shift+x exec --no-startup-id        myswaylock 
          bindsym $mod+t exec --no-startup-id              telegram-desktop
          bindsym $mod+q exec --no-startup-id              nvidia-offload icalingua-plus-plus --enable-features=UseOzonePlatform --ozone-platform=wayland
          bindsym $mod+bracketleft  exec --no-startup-id   grimshot --notify  save area ~/Pictures/$(date "+%Y-%m-%d"T"%H:%M:%S_no_watermark").png
          bindsym $mod+bracketright exec --no-startup-id   grimshot --notify  copy area 
          bindsym $mod+a exec --no-startup-id              grimshot_watermark


          # Kill focused window
          bindsym $mod+Shift+p kill

          # Start your launcher
          bindsym Super_L exec pkill rofi || ~/.config/rofi/launcher.sh

          # Start your powermenu
          bindsym $mod+Super_L exec bash ~/.config/rofi/powermenu.sh

          # Reload the configuration file
          bindsym $mod+Shift+c reload

          # Exit sway (logs you out of your Wayland session)
          bindsym $mod+Shift+e exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'

          # Drag floating windows by holding down $mod and left mouse button.
          # Resize them with right mouse button + $mod.
          # Despite the name, also works for non-floating windows.
          # Change normal to inverse to use left mouse button for resizing and right
          # mouse button for dragging.
          floating_modifier $mod normal

      #----------------#
      # Moving around: #
      #----------------#
          # Move your focus around
          bindsym $mod+$left focus left
          bindsym $mod+$down focus down
          bindsym $mod+$up focus up
          bindsym $mod+$right focus right
          # Or use $mod+[up|down|left|right]
          bindsym $mod+Left focus left
          bindsym $mod+Down focus down
          bindsym $mod+Up focus up
          bindsym $mod+Right focus right

          # Move the focused window with the same, but add Shift
          bindsym $mod+Shift+$left move left
          bindsym $mod+Shift+$down move down
          bindsym $mod+Shift+$up move up
          bindsym $mod+Shift+$right move right
          # Ditto, with arrow keys
          bindsym $mod+Shift+Left move left
          bindsym $mod+Shift+Down move down
          bindsym $mod+Shift+Up move up
          bindsym $mod+Shift+Right move right
      #-------------#
      # Workspaces: #
      #-------------#
          # Switch to workspace
          bindsym $mod+1 workspace number 1
          bindsym $mod+2 workspace number 2
          bindsym $mod+3 workspace number 3
          bindsym $mod+4 workspace number 4
          bindsym $mod+5 workspace number 5
          bindsym $mod+6 workspace number 6
          bindsym $mod+7 workspace number 7
          bindsym $mod+8 workspace number 8
          bindsym $mod+9 workspace number 9
          bindsym $mod+0 workspace number 10
          # Move focused container to workspace
          bindsym $mod+Shift+1 move container to workspace number 1
          bindsym $mod+Shift+2 move container to workspace number 2
          bindsym $mod+Shift+3 move container to workspace number 3
          bindsym $mod+Shift+4 move container to workspace number 4
          bindsym $mod+Shift+5 move container to workspace number 5
          bindsym $mod+Shift+6 move container to workspace number 6
          bindsym $mod+Shift+7 move container to workspace number 7
          bindsym $mod+Shift+8 move container to workspace number 8
          bindsym $mod+Shift+9 move container to workspace number 9
          bindsym $mod+Shift+0 move container to workspace number 10
          # move focused container to workspace(follow)
          bindsym $mod+Ctrl+1 move container to workspace number 1,  workspace 1
          bindsym $mod+Ctrl+2 move container to workspace number 2,  workspace 2
          bindsym $mod+Ctrl+3 move container to workspace number 3,  workspace 3
          bindsym $mod+Ctrl+4 move container to workspace number 4,  workspace 4
          bindsym $mod+Ctrl+5 move container to workspace number 5,  workspace 5
          bindsym $mod+Ctrl+6 move container to workspace number 6,  workspace 6
          bindsym $mod+Ctrl+7 move container to workspace number 7,  workspace 7
          bindsym $mod+Ctrl+8 move container to workspace number 8,  workspace 8
          bindsym $mod+Ctrl+9 move container to workspace number 9,  workspace 9
          bindsym $mod+Ctrl+0 move container to workspace number 10, workspace 10
          # Note: workspaces can have any name you want, not just numbers.
          # We just use 1-10 as the default.
      #---------------#
      # Layout stuff: #
      #---------------#
          # You can "split" the current object of your focus with
          # $mod+semicolon or $mod+apostrophe, for horizontal and vertical splits
          # respectively.
          bindsym $mod+semicolon splitv
          bindsym $mod+apostrophe splith

          # Switch the current container between different layout styles
          bindsym $mod+s layout stacking
          bindsym $mod+w layout tabbed
          bindsym $mod+e layout toggle split

          # Make the current focus fullscreen
          bindsym $mod+f fullscreen

          # Toggle the current focus between tiling and floating mode
          bindsym $mod+Shift+space floating toggle

          # Swap focus between the tiling area and the floating area
          bindsym $mod+space focus mode_toggle

          # Move focus to the parent container
          bindsym $mod+p focus parent
          # Move focus the child container
          bindsym $mod+c focus child
      #-------------#
      # Scratchpad: #
      #-------------#
      ## hide | show window(minus is "-" and plus is "+".)
      bindsym $mod+minus move scratchpad
      bindsym $mod+equal scratchpad show

      #----------------------#
      # Resizing containers: #
      #----------------------#
      bindsym $mod+r mode "resize"
      mode "resize" {
          # left will shrink the containers width
          # right will grow the containers width
          # up will shrink the containers height
          # down will grow the containers height
          bindsym $left resize shrink width 10px
          bindsym $up resize grow height 10px
          bindsym $down resize shrink height 10px
          bindsym $right resize grow width 10px

          # Ditto, with arrow keys
          bindsym Left resize shrink width 10px
          bindsym Up resize grow height 10px
          bindsym Down resize shrink height 10px
          bindsym Right resize grow width 10px

          # Return to default mode
          bindsym Return mode "default"
          bindsym Escape mode "default"
      }
      ## Better to resize window
      bindsym Shift+Ctrl+h             resize shrink width  5 px or 5 ppt
      bindsym Shift+Ctrl+k             resize grow   height 5 px or 5 ppt
      bindsym Shift+Ctrl+j             resize shrink height 5 px or 5 ppt
      bindsym Shift+Ctrl+l             resize grow   width  5 px or 5 ppt
      bindsym Shift+Ctrl+Left          resize shrink width  5 px or 5 ppt
      bindsym Shift+Ctrl+Up            resize grow   height 5 px or 5 ppt
      bindsym Shift+Ctrl+Down          resize shrink height 5 px or 5 ppt
      bindsym Shift+Ctrl+Right         resize grow   width  5 px or 5 ppt
    '';
  };
}
