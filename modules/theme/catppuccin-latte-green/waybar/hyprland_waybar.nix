{ config, lib, pkgs, ... }:

let
  user = "ruixi";
in
{
  home-manager.users.${user} = {
    # Home-manager waybar config
    programs.waybar = {
      enable = true;
    };
    home.file = {
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
