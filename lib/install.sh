function install_repo() {
    local group=$1
    local name=$2;

    if [[ ! -d ${name} && ! -z ${name} ]]; then
        printf ${C_BG_DULL_BLUE}${C_FG_WHITE}"     Cloning $group/$name     "${C_RESET}"\n"

        git clone git@github.com:H4mmp3l/${group}/${name}.git
        local git_status=$?

        printf ${C_BG_DULL_GREEN}${C_FG_WHITE}"     OK     "${C_RESET}"\n"
        printf "\n"

        return ${git_status}
    fi

    return 1
}

function delete_repo() {
    local name=$1;

    if [[ -d ${name} && ! -z ${name} ]]; then
        printf ${C_BG_DULL_RED}${C_FG_WHITE}"     Deleting $name     "${C_RESET}"\n"

        rm -rf ${name}

        printf ${C_BG_DULL_GREEN}${C_FG_WHITE}"     OK     "${C_RESET}"\n"
        printf "\n"
    fi
}

function setup_repo() {
    local name=$1;

    printf ${C_BG_DULL_BLUE}${C_FG_WHITE}"     Setting up $name     "${C_RESET}"\n"

    if [[ -e "${name}/Makefile" ]]; then
        vagrant ssh -c "cd /vagrant/$name && make build-local"
    fi
    
    printf ${C_BG_DULL_GREEN}${C_FG_WHITE}"     OK     "${C_RESET}"\n"
    printf "\n"
}
