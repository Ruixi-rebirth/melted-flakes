#!/usr/bin/env bash
theme="launcher_theme"
dir="$HOME/.config/rofi/"

# catppuccin
ALPHA="#00000000"
BG="#24273A"
FG="#BF616A"
SELECT="#1E1E2E"
ACCENT="#24273A"

# nord
#ALPHA="#00000000"
#BG="#3B4253"
#FG="#BF616A"
#SELECT="#343a46"
#ACCENT="#3B4252"

# overwrite colors file
cat > $dir/colors.rasi <<- EOF
	/* colors */

	* {
	  al:  $ALPHA;
	  bg:  $BG;
	  se:  $SELECT;
	  fg:  $FG;
	  ac:  $ACCENT;
	}
EOF

rofi -no-lazy-grab -show drun -modi drun -theme $dir/"$theme"

