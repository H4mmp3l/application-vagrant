#!/usr/bin/env bash
set -euo pipefail

# DEBUG:
#set -x

source lib/colors.sh
source lib/yaml.sh
source lib/install.sh
source lib/vagrant.sh

create_variables config.yaml
create_variables local.yaml

if [ ! $# == 2 ]; then
    echo "Usage: ./install.sh [namespace] [repository-name]";
    exit 1
fi

vagrant_is_stopped && start_vagrant

if [[ ! -d "./${1}" ]] ; then
	delete_repo ${1}
	install_repo ${1} ${2}
fi

setup_repo ${1}
rewrite_hosts

exit 0
