{ config, pkgs, lib, ... }:
{
  config = lib.mkIf (config.xsession.enable) {
    services.sxhkd = {
      enable = true;
      keybindings = {
        #use ` xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }' ` will get the key name
        "alt + Return" = "kitty fish";
        "alt + shift + Return" = "kitty --class='termfloat' fish";
        "alt + Escape" = "pkill -USER1 -x sxhkd";
        "alt + shift + p" = "bspc node -c";
        "alt + shift + {q,r}" = "bspc {quit,wm -r}";
        "alt + shift + space" = "bspc node focused -t \~floating";
        "alt + shift + g" = "bspc config window_gap 5";
        "alt + g" = "bspc config window_gap 0";
        "alt + k" = "bspc desktop -l next";
        "alt + s" = "bspc node -s biggest.window";
        "alt + y" = "bspc node newest.marked.local -n newest.!automatic.local";
        "alt + ctrl + {m,x,y,z}" = "bspc node -g {marked,locked,sticky,private}";
        "alt + ctrl + {p,b,comma,period}" = "bspc node -f @{parent,brother,first,second}";
        "alt + shift + {comma,period}" = "bspc node -f {prev,next}.local.!hidden.window";
        "alt + {comma,period}" = "bspc desktop -f {prev,next}.local";
        "alt + {grave,Tab}" = "bspc {node,desktop} -f last";
        "alt + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";
        "alt + {_,shift + }{Left,Down,Up,Right}" = "bspc node -{f,s} {west,south,north,east}";
        "alt + ctrl + {h,j,k,l}" = "bspc node -p {\~west,\~south,\~north,\~east}";
        "alt + ctrl + {Left,Down,Up,Right}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";
        "ctrl + shift + {Left,Down,Up,Right}" = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
        "Contril_L + alt + shift + {h,j,k,l}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
        "alt + ctrl + {1-9}" = "bspc node -o 0.{1-9}";
        "alt + f" = "bspc node -t \~fullscreen";
        "alt + p" = "bspc node -t \~pseudo_tiled";
        "alt + ctrl + t" = "bspc node -t \~tiled";
        "alt + v" = "bspc node -g hidden";
        "alt + shift + v" = "bspc node {,$(bspc query -N -n .hidden | tail -n1)} -g hidden=off";
        "XF86AudioRaiseVolume" = "pamixer -i 5";
        "XF86AudioLowerVolume" = "pamixer -d 5";
        "XF86AudioMute" = "pamixer -t";
        "XF86AudioMicMute" = "pamixer --default-source -t";
        "XF86MonBrightnessUp" = "light -A 5";
        "XF86MonBrightnessDown" = "light -U 5";
        "XF86AudioPlay" = "mpc -q toggle";
        "XF86AudioNext" = "mpc -q next";
        "XF86AudioPrev" = "mpc -q prev";
        "alt + b" = "nvidia-offload firefox";
        "alt + m" = "netease-cloud-music-gtk4";
        "alt + shift + m" = "kitty --class='musicfox' 'musicfox'";
        "alt + shift +d" = "kitty  --class='danmufloat' --hold sh -c 'cd /home/ruixi/Codelearning/go/src/bilibili_live_tui/  && export TERM=xterm-256color && go run main.go -c config.toml'";
        "alt + t" = "telegram-desktop";
        "alt + q" = "nvidia-offload icalingua-plus-plus";
        "alt + a" = "flameshot_watermark";
        "Super_L" = "pkill rofi || bash ~/.config/rofi/launcher.sh";
        "alt + Super_L" = "bash ~/.config/rofi/powermenu.sh";
        "alt + o" = "polybar-msg cmd toggle";
        "alt + shift +x" = "i3lock-fancy -p";
        "alt + w" = ''feh --randomize --bg-fill $(find ~/Pictures/wallpaper/. -name "*.png" | shuf -n1)'';
      };
    };
  };
}
