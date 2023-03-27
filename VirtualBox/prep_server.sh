#!/bin/bash
set -x
IPADDRESS=$1
CLEAN=true
BASEDIR=/Users/meshulam/VirtualBox\ VMs
cd "$BASEDIR"


if [ -f ~/.ssh/id_ras.pub ]; then
    echo "No SSH key, exiting"
    exiting
fi

scp ~/.ssh/id_ras.pub arnon@${IPADDRESS}:/home/arnon/.ssh/
