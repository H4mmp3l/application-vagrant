#!/usr/bin/env bash
# https://gist.github.com/erikw/2772489
# Source this file where ANSI colors are needed. Colors in strings should be quoted with "" and echos needs to interpret backslash (echo -e).
# Reference: http://www.faqs.org/docs/Linux-HOWTO/Bash-Prompt-HOWTO.html#AEN341

function export_colors() {
	# ANSI colors codes.
	local DULL=0
	local BRIGHT=1

	local FG_NULL=00
	local FG_BLACK=30
	local FG_RED=31
	local FG_GREEN=32
	local FG_YELLOW=33
	local FG_BLUE=34
	local FG_MAGENTA=35
	local FG_CYAN=36
	local FG_WHITE=37

	local BG_NULL=00
	local BG_BLACK=40
	local BG_RED=41
	local BG_GREEN=42
	local BG_YELLOW=43
	local BG_BLUE=44
	local BG_MAGENTA=45
	local BG_CYAN=46
	local BG_WHITE=47


	local ESC="\033"	# Escape code. Can also be "\e".

	# Color variables.
	C_NORMAL="$ESC[m"
	C_RESET="$ESC[${DULL};${FG_WHITE};${BG_NULL}m"
	C_HICOLOR="$ESC[1m"			# Hicolor.
	C_UNDERLINE="$ESC[4m"			# Underline.
	C_INVERSE="$ESC[7m"			# Inverse background and foreground.


	# Foreground colors.
	C_FG_BLACK="$ESC[${FG_BLACK}m"		# Foreground black.
	C_FG_RED="$ESC[$FG_RED}m" 		# Foreground red.
	C_FG_GREEN="$ESC[${FG_GREEN}m" 		# Foreground green.
	C_FG_YELLOW="$ESC[${FG_YELLOW}m" 	# Foreground yellow.
	C_FG_BLUE="$ESC[${FG_BLUE}m" 		# Foreground blue.
	C_FG_MAGENTA="$ESC[${FG_MAGENTA}m" 	# Foreground magenta.
	C_FG_CYNAN="$ESC[${FG_CYAN}m" 		# Foreground cyan.
	C_FG_WHITE="$ESC[${FG_WHITE}m" 		# Foreground white.

	# Background colors.
	C_BG_BLACK="$ESC[${BG_BLACK}m" 		# Background black.
	C_BG_RED="$ESC[${BG_RED}m" 		    # Background red.
	C_BG_GREEN="$ESC[${BG_GREEN}m" 		# Background green.
	C_BG_YELLOW="$ESC[${BG_YELLOW}m" 	# Background yellow.
	C_BG_BLUE="$ESC[${BG_BLUE}m" 		# Background blue.
	C_BG_MAGENTA="$ESC[${BG_MAGENTA}m" 	# Background magenta.
	C_BG_CYAN="$ESC[${BG_CYAN}m" 		# Background cyan.
	C_BG_WHITE="$ESC[${BG_WHITE}m" 		# Background white.

	# Dull FG.
	C_FG_DULL_BLACK="$ESC[${DULL};${FG_BLACK}m"
	C_FG_DULL_RED="$ESC[${DULL};${FG_RED}m"
	C_FG_DULL_GREEN="$ESC[${DULL};${FG_GREEN}m"
	C_FG_DULL_YELLOW="$ESC[${DULL};${FG_YELLOW}m"
	C_FG_DULL_BLUE="$ESC[${DULL};${FG_BLUE}m"
	C_FG_DULL_MAGENTA="$ESC[${DULL};${FG_MAGENTA}m"
	C_FG_DULL_CYAN="$ESC[${DULL};${FG_CYAN}m"
	C_FG_DULL_WHITE="$ESC[${DULL};${FG_WHITE}m"

	# Bright FG.
	C_FG_BRIGHT_BLACK="$ESC[${BRIGHT};${FG_BLACK}m"
	C_FG_BRIGHT_RED="$ESC[${BRIGHT};${FG_RED}m"
	C_FG_BRIGHT_GREEN="$ESC[${BRIGHT};${FG_GREEN}m"
	C_FG_BRIGHT_YELLOW="$ESC[${BRIGHT};${FG_YELLOW}m"
	C_FG_BRIGHT_BLUE="$ESC[${BRIGHT};${FG_BLUE}m"
	C_FG_BRIGHT_MAGENTA="$ESC[${BRIGHT};${FG_MAGENTA}m"
	C_FG_BRIGHT_CYAN="$ESC[${BRIGHT};${FG_CYAN}m"
	C_FG_BRIGHT_WHITE="$ESC[${BRIGHT};${FG_WHITE}m"

	# Dull BG.
	C_BG_DULL_BLACK="$ESC[${DULL};${BG_BLACK}m"
	C_BG_DULL_RED="$ESC[${DULL};${BG_RED}m"
	C_BG_DULL_GREEN="$ESC[${DULL};${BG_GREEN}m"
	C_BG_DULL_YELLOW="$ESC[${DULL};${BG_YELLOW}m"
	C_BG_DULL_BLUE="$ESC[${DULL};${BG_BLUE}m"
	C_BG_DULL_MAGENTA="$ESC[${DULL};${BG_MAGENTA}m"
	C_BG_DULL_CYAN="$ESC[${DULL};${BG_CYAN}m"
	C_BG_DULL_WHITE="$ESC[${DULL};${BG_WHITE}m"

	# Bright BG.
	C_BG_BRIGHT_BLACK="$ESC[${BRIGHT};${BG_BLACK}m"
	C_BG_BRIGHT_RED="$ESC[${BRIGHT};${BG_RED}m"
	C_BG_BRIGHT_GREEN="$ESC[${BRIGHT};${BG_GREEN}m"
	C_BG_BRIGHT_YELLOW="$ESC[${BRIGHT};${BG_YELLOW}m"
	C_BG_BRIGHT_BLUE="$ESC[${BRIGHT};${BG_BLUE}m"
	C_BG_BRIGHT_MAGENTA="$ESC[${BRIGHT};${BG_MAGENTA}m"
	C_BG_BRIGHT_CYAN="$ESC[${BRIGHT};${BG_CYAN}m"
	C_BG_BRIGHT_WHITE="$ESC[${BRIGHT};${BG_WHITE}m"
}

export_colors
