{ config, lib, pkgs, ... }:

let
  user = "ruixi";
in
{
  environment.systemPackages = with pkgs; [
    waybar
  ];

  nixpkgs.overlays = [
    (final: prev: {
      waybar =
        let
          hyprctl = "${pkgs.hyprland}/bin/hyprctl";
          waybarPatchFile = import ./workspace-patch.nix { inherit pkgs hyprctl; };
        in
        prev.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
          patches = (oldAttrs.patches or [ ]) ++ [ waybarPatchFile ];
        });
    })
  ];

  home-manager.users.${user} = {
    # Home-manager waybar config
    programs.waybar = {
      enable = true;
      #other config & style
    };
    home.file = {
      ".config/waybar/light_config".text = ''
        [
          {
            "backlight": {
              "device": "intel_backlight",
              "format": "{icon} {percent}%",
              "format-icons": [
                "",
                "",
                "",
                ""
              ],
              "on-scroll-down": "light -U 5",
              "on-scroll-up": "light -A 5"
            },
            "battery": {
              "format": "{icon} {capacity}%",
              "format-charging": " {capacity}%",
              "format-full": "{icon} {capacity}%",
              "format-icons": [
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                ""
              ],
              "interval": 10,
              "states": {
                "critical": 10,
                "warning": 20
              },
              "tooltip": false
            },
            "clock": {
              "format": "{:%I:%M %p  %A %b %d}",
              "interval": 1,
              "on-click": "wallpaper_random",
              "on-click-right": "killall dynamic_wallpaper || dynamic_wallpaper &",
              "tooltip": true,
              "tooltip-format": "上午：高数\n下午：Ps\n晚上：Golang\n<tt>{calendar}</tt>"
            },
            "cpu": {
              "format": " {usage}%",
              "interval": 1
            },
            "custom/cava-internal": {
              "exec": "sleep 1s && cava-internal",
              "tooltip": false
            },
            "custom/launcher": {
              "format": " ",
              "on-click": "pkill rofi || ~/.config/rofi/launcher.sh",
              "tooltip": false
            },
            "custom/style-switch": {
              "format": "ﴔ",
              "on-click": "default_waybar &",
              "tooltip": false
            },
            "custom/powermenu": {
              "format": "",
              "on-click": "pkill rofi || ~/.config/rofi/powermenu.sh",
              "tooltip": false
            },
            "idle_inhibitor": {
              "format": "{icon}",
              "format-icons": {
                "activated": "",
                "deactivated": ""
              },
              "tooltip": false
            },
            "layer": "top",
            "memory": {
              "format": "﬙ {percentage}%",
              "interval": 1,
              "states": {
                "warning": 85
              }
            },
            "modules-center": [
              "clock"
            ],
            "modules-left": [
              "custom/launcher",
              "wlr/workspaces",
              "temperature",
              //"idle_inhibitor",
              "custom/style-switch",
              "mpd",
              "custom/cava-internal"
            ],
            "modules-right": [
              "pulseaudio",
              "backlight",
              "memory",
              "cpu",
              "network",
              "battery",
              "custom/powermenu",
              "tray"
            ],
            "mpd": {
              "format": "<span foreground='#FF99FF'></span> {title}",
              "format-disconnected": "",
              "format-paused": " {title}",
              "format-stopped": "<span foreground='#bb9af7'></span>",
              "max-length": 25,
              "on-click": "mpc --quiet toggle",
              "on-click-middle": "kitty --class='ncmpcpp' ncmpcpp ",
              "on-click-right": "mpc ls | mpc add",
              "on-scroll-down": "mpc --quiet next",
              "on-scroll-up": "mpc --quiet prev",
              "smooth-scrolling-threshold": 5,
              "tooltip-format": "{title} - {artist} ({elapsedTime:%M:%S}/{totalTime:%H:%M:%S})"
            },
            "network": {
              "format-disconnected": "說 Disconnected",
              "format-ethernet": "  {ifname} ({ipaddr})",
              "format-linked": "說 {essid} (No IP)",
              "format-wifi": "說 {essid}",
              "interval": 1,
              "tooltip": false
            },
            "position": "top",
            "pulseaudio": {
              "format": "{icon} {volume}%",
              "format-icons": {
                "default": [
                  "",
                  "",
                  ""
                ]
              },
              "format-muted": "婢 Muted",
              "on-click": "pamixer -t",
              "scroll-step": 1,
              "states": {
                "warning": 85
              },
              "tooltip": false
            },
            "temperature": {
              "format": " {temperatureC}°C",
              "tooltip": false
            },
            "tray": {
              "icon-size": 15,
              "spacing": 5
            },
            "wlr/workspaces": {
              "format": "{icon}",
              "on-click": "activate",
              "active-only": false,
            }
          }
        ]
      '';
      ".config/waybar/light_style.css".text = ''
              * {
                font-family: "JetBrainsMono Nerd Font";
                font-size: 12pt;
                font-weight: bold;
                border-radius: 0px;
                transition-property: background-color;
                transition-duration: 0.5s;
              }
              @keyframes blink_red {
                to {
                  background-color: rgb(242, 143, 173);
                  color: rgb(26, 24, 38);
                }
              }
              .warning, .critical, .urgent {
                animation-name: blink_red;
                animation-duration: 1s;
                animation-timing-function: linear;
                animation-iteration-count: infinite;
                animation-direction: alternate;
              }
              window#waybar {
                background-color: transparent;
              }
              window > box {
                margin-left: 5px;
                margin-right: 5px;
                margin-top: 5px;
                background-color: rgb(250, 244, 252);
              }
        #workspaces {
                padding-left: 0px;
                padding-right: 4px;
              }
        #workspaces button {
                padding-top: 5px;
                padding-bottom: 5px;
                padding-left: 6px;
                padding-right: 6px;
                color:#99CCFF;
              }
        #workspaces button.active {
                background-color: rgb(181, 232, 224);
                color: rgb(26, 24, 38);
              }
        #workspaces button.urgent {
                color: rgb(26, 24, 38);
              }
        #workspaces button:hover {
                background-color: #CCCCFF;
                color: rgb(26, 24, 38);
              }
              tooltip {
                /* background: rgb(250, 244, 252); */
                background: rgb(250, 244, 252);
              }
              tooltip label {
                color: rgb(65, 72, 104);
              }
        #custom-launcher {
                font-size: 20px;
                padding-left: 8px;
                padding-right: 6px;
                color: #7ebae4;
              }
        #mode, #clock, #memory, #temperature,#cpu,#mpd, #custom-style-switch, #temperature, #backlight, #pulseaudio, #network, #battery, #custom-powermenu, #custom-cava-internal {
                padding-left: 10px;
                padding-right: 10px;
              }
              /* #mode { */
              /* 	margin-left: 10px; */
              /* 	background-color: rgb(248, 189, 150); */
              /*     color: rgb(26, 24, 38); */
              /* } */
        #memory {
                color: #66CCFF;
              }
        #cpu {
                color: #FF99FF;
              }
        #clock {
                color: rgb(65, 72, 104);
              }
        /*
        #idle_inhibitor {
        color: #FF6699;
        }*/
        #custom-style-switch {
                color: #FF6699;
              }
        #temperature {
                color: #9933FF;
              }
        #backlight {
                color: #6666FF;
              }
        #pulseaudio {
                color: #FF9900;
              }
        #network {
                color: #00CC66;
              }

        #network.disconnected {
                color: #99CCCC;
              }
        #battery.charging, #battery.full, #battery.discharging {
                color: #FF99CC;
              }
        #battery.critical:not(.charging) {
                color: rgb(242, 143, 173);
              }
        #custom-powermenu {
                color: #FF0066;
              }
        #tray {
                padding-right: 8px;
                padding-left: 10px;
              }
        #tray menu {
                background: rgb(250, 244, 252);
                color:rgb(192, 202, 245);
        }
        #mpd.paused {
                color: rgb(192, 202, 245);
                font-style: italic;
              }
        #mpd.stopped {
                background: transparent;
              }
        #mpd {
                  color: rgb(65, 72, 104);

                /* color: #c0caf5; */
              }
        #custom-cava-internal{
                font-family: "Hack Nerd Font" ;
              }
      '';
    };
  };
}
