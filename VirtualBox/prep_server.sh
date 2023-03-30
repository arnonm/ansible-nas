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

scp ~/.ssh/id_rsa.pub hda_admin@${IPADDRESS}:/home/hda_admin/.ssh/authorized_keys
