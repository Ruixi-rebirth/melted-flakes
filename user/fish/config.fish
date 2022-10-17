if status is-interactive
    # Commands to run in interactive sessions can go here
end

#start X at login
#if status --is-login
#    if test -z "$DISPLAY" -a $XDG_VTNR = 1
#        exec startx
#    end
#end

# If running from tty1 start sway
set TTY1 (tty)
[ "$TTY1" = "/dev/tty1" ] && exec dbus-run-session sway --unsupported-gpu


# If running from tty1 start Hyprland
#set TTY1 (tty)
#[ "$TTY1" = "/dev/tty1" ] && exec Hyprland
