#!/bin/bash

# Aim of this file is:
#  - contain functions for pretty-printing test results
#  - allow uniform response across homework
#  - simplify gitlab-ci.yml file (by bundling recurring cmds)

# This file is included in the root folder of every bs-stud repo
# (it will be overwritten on the "Abgabe"-Branch for safety)

# USAGE:
#
# print-points <reached> <maximum>
# print-warn <text>
# print-fail <text>
# print-succ <text>

# Color definitions
BSC_RED='\e[31m'
BSC_GREEN='\e[32m'
BSC_YELLOW='\e[33m'
BSC_BLUE='\e[34m'
BSC_MAGENTA='\e[35m'
BSC_CYAN='\e[36m'

# Formatting definitions
BSC_BOLD='\e[1m'
BSC_RESET='\e[0m'
BSC_UNDERLINE='\e[4m'
BSC_BLINK='\e[5m'
BSC_REVERSE='\e[7m'

# Usage definitions
BSC_SUCCESS="${BSC_BOLD}${BSC_GREEN}"
BSC_FAILURE="${BSC_BOLD}${BSC_RED}"
BSC_WARNING="${BSC_BOLD}${BSC_YELLOW}"
BSC_PREFIXC="${BSC_RESET}${BSC_BOLD}"

BSC_PREFIX_SUCCESS="SUCCESS"
BSC_PREFIX_WARNING="WARNING"
BSC_PREFIX_FAILURE="FAILURE"

BSC_SUMMARY="\e[30;47;1m" # make summary black on white

#functions:
function print-prefix {
    echo -en "${BSC_PREFIXC}[${BSC_RESET}$1${BSC_PREFIXC}]${BSC_RESET}"
}

function print-warn-text {
    echo -e "$(print-prefix ${BSC_PREFIX_WARNING}) ${BSC_WARNING}$@${BSC_RESET}"
}

function print-fail-text {
    echo -e "$(print-prefix ${BSC_PREFIX_FAILURE}) ${BSC_FAILURE}$@${BSC_RESET}"
}

function print-succ-text {
    echo -e "$(print-prefix ${BSC_PREFIX_SUCCESS}) ${BSC_SUCCESS}$@${BSC_RESET}"
}

function print-warn-prefix {
    echo -e "$(print-prefix ${BSC_WARNING}${BSC_PREFIX_WARNING}) $@"
}

function print-fail-prefix {
    echo -e "$(print-prefix ${BSC_FAILURE}${BSC_PREFIX_FAILURE}) $@"
}

function print-succ-prefix {
    echo -e "$(print-prefix ${BSC_SUCCESS}${BSC_PREFIX_SUCCESS}) $@"
}

alias print-succ='print-succ-prefix'
alias print-fail='print-fail-prefix'
alias print-warn='print-warn-prefix'

function __print-test {
    echo "current aliases:"
    print-succ starting application
    print-warn files not found
    print-succ application reacted
    print-fail segfault encountered
    print-warn not all test ran successfully

    echo "prefixes:"
    print-succ-prefix starting application
    print-warn-prefix files not found
    print-succ-prefix application reacted
    print-fail-prefix segfault encountered
    print-warn-prefix not all test ran successfully

    echo "text:"
    print-succ-text starting application
    print-warn-text files not found
    print-succ-text application reacted
    print-fail-text segfault encountered
    print-warn-text not all test ran successfully
}

# rounds down to show progress bar
function __print-points-bar {
    estimate=$1;
    maximum=$2;
    let width=41;

    let percent=(${estimate} * 100 / ${maximum} * 100)/100;
    let num_hash_part=${width}/10;
    let num_hash_part=${num_hash_part}*${percent}
    let num_hash=${num_hash_part}/10;
    let num_space=$width-$num_hash;

    if [ "$estimate" -eq "$maximum" ]; then
	num_hash=${width}
	num_space="0"
    fi
    _hash=$(printf "%${num_hash}s");
    _space=$(printf "%${num_space}s");

    echo "[${_hash// /\#}${_space// /-}]";
}

function __print-summary-line {
    echo -e "${BSC_RESET}    ${BSC_SUMMARY}$@${BSC_RESET}"
}

function print-points {
    aufgabe=$(basename $(pwd)) # Aufgabenname
    gruppe=$(basename $(git rev-parse --show-toplevel)) # Gruppenname
    curp=$1 # erreichte Punktezahl
    maxp=$2 # maximale Punktezahl

    echo ""
    __print-summary-line "╔═════════════════════════════════════════════╗"
    __print-summary-line "║                Zusammenfassung              ║█"
    __print-summary-line "╟─────────────────────────────────────────────╢█"
    __print-summary-line "║ Aufgabe: $(printf %34s "$aufgabe") ║█"
    __print-summary-line "║ Gruppe:  $(printf %34s "$gruppe") ║█"
    __print-summary-line "║                                             ║█"
    __print-summary-line "║ vorraussichtlich erreichte Punkte: $(printf %2s "$curp") / $(printf %2s "$maxp")  ║█"
    __print-summary-line "║                                             ║█"
    __print-summary-line "║ $(__print-points-bar $curp $maxp) ║█"
    __print-summary-line "╚═════════════════════════════════════════════╝█"
    echo -n " "; __print-summary-line "███████████████████████████████████████████████"
    echo ""

}
