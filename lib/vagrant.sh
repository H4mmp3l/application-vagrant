#!/usr/bin/env bash
function vagrant_is_stopped() {
    vagrant status | grep default | grep stopped >> /dev/null
    return $?
}

function start_vagrant() {
    printf ${C_BG_DULL_GREEN}${C_FG_WHITE}"     Booting Vagrant     "${C_RESET}"\n"

    vagrant up

    printf ${C_BG_DULL_GREEN}${C_FG_WHITE}"     OK     "${C_RESET}"\n"
    printf "\n"
}

function rewrite_hosts() {
    vagrant hostmanager
}
