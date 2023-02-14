#!/usr/bin/env bash
set -e
set -u

# All supported choices
all=(shutdown reboot suspend hibernate  logout lockscreen)

# By default, show all (i.e., just copy the array)
show=("${all[@]}")

declare -A texts
texts[lockscreen]="lock screen"
texts[logout]="logout"
texts[suspend]="suspend"
texts[hibernate]="hibernate"
texts[reboot]="reboot"
texts[shutdown]="shutdown"

declare -A icons
icons[lockscreen]="\uf023"
icons[suspend]="\u23fe"
icons[logout]="\uf842"
icons[hibernate]="\uf7c9"
icons[reboot]="\ufc07"
icons[shutdown]="\uf011"
icons[cancel]="\u00d7"

declare -A actions
actions[lockscreen]="myswaylock"
actions[logout]="loginctl terminate-session ${XDG_SESSION_ID-}"
actions[hibernate]="systemctl hibernate"
actions[suspend]="systemctl suspend"
actions[reboot]="systemctl reboot"
actions[shutdown]="systemctl poweroff"

# By default, ask for confirmation for actions that are irreversible
confirmations=(reboot shutdown logout)

# By default, no dry run
dryrun=false
showsymbols=true

function check_valid {
    option="$1"
    shift 1
    for entry in "${@}"
    do
        if [ -z "${actions[$entry]+x}" ]
        then
            echo "Invalid choice in $1: $entry" >&2
            exit 1
        fi
    done
}


# Define the messages after parsing the CLI options so that it is possible to
# configure them in the future.

function write_message {
    icon="<span font_size=\"medium\">$1</span>"
    text="<span font_size=\"medium\">$2</span>"
    if [ "$showsymbols" = "true" ]
    then
        echo -n "\u200e$icon \u2068$text\u2069"
    else
        echo -n "$text"
    fi
}

function print_selection {
    echo -e "$1" | $(read -r -d '' entry; echo "echo $entry")
}

declare -A messages
declare -A confirmationMessages
for entry in "${all[@]}"
do
    messages[$entry]=$(write_message "${icons[$entry]}" "${texts[$entry]^}")
done
for entry in "${all[@]}"
do
    confirmationMessages[$entry]=$(write_message "${icons[$entry]}" "Yes, ${texts[$entry]}")
done
confirmationMessages[cancel]=$(write_message "${icons[cancel]}" "No, cancel")

if [ $# -gt 0 ]
then
    # If arguments given, use those as the selection
    selection="${@}"
else
    # Otherwise, use the CLI passed choice if given
    if [ -n "${selectionID+x}" ]
    then
        selection="${messages[$selectionID]}"
    fi
fi

# Don't allow custom entries
echo -e "\0no-custom\x1ftrue"
# Use markup
echo -e "\0markup-rows\x1ftrue"

if [ -z "${selection+x}" ]
then
    echo -e "\0prompt\x1fPower menu"
    for entry in "${show[@]}"
    do
        echo -e "${messages[$entry]}\0icon\x1f${icons[$entry]}"
    done
else
    for entry in "${show[@]}"
    do
        if [ "$selection" = "$(print_selection "${messages[$entry]}")" ]
        then
            # Check if the selected entry is listed in confirmation requirements
            for confirmation in "${confirmations[@]}"
            do
                if [ "$entry" = "$confirmation" ]
                then
                    # Ask for confirmation
                    echo -e "\0prompt\x1fAre you sure"
                    echo -e "${confirmationMessages[$entry]}\0icon\x1f${icons[$entry]}"
                    echo -e "${confirmationMessages[cancel]}\0icon\x1f${icons[cancel]}"
                    exit 0
                fi
            done
            # If not, then no confirmation is required, so mark confirmed
            selection=$(print_selection "${confirmationMessages[$entry]}")
        fi
        if [ "$selection" = "$(print_selection "${confirmationMessages[$entry]}")" ]
        then
            if [ $dryrun = true ]
            then
                # Tell what would have been done
                echo "Selected: $entry" >&2
            else
                # Perform the action
                ${actions[$entry]}
            fi
            exit 0
        fi
        if [ "$selection" = "$(print_selection "${confirmationMessages[cancel]}")" ]
        then
            # Do nothing
            exit 0
        fi
    done
    # The selection didn't match anything, so raise an error
    echo "Invalid selection: $selection" >&2
    exit 1
fi
