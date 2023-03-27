#!/bin/bash
set -x
MACHINENAME=$1
CLEAN=true
BASEDIR=/Users/meshulam/Source/ansible-nas/workingdir
VMDIR="/Users/meshulam/VirtualBox VMs"
mkdir -p $BASEDIR
cd $BASEDIR

# Download debian.iso
if [ ! -f ${BASEDIR}/ubuntu22.iso ]; then
    wget https://releases.ubuntu.com/jammy/ubuntu-22.04.2-live-server-amd64.iso -O ${BASEDIR}/ubuntu22.iso
fi

# Check for docker image
    #mkdir -p ${BASEDIR}/cidata
    #cp ${BASEDIR}/../VirtualBox/user-data ${BASEDIR}/cidata/
    #cp ${BASEDIR}/../VirtualBox/meta-data ${BASEDIR}/cidata/
    # docker run -v ${BASEDIR}:/mount oshothebig/cloud-image-utils cloud-localds /mount/ubuntu22.iso /mount/cidata/user-data /mount/cidata/meta-data
    # cloud-localds ./ubuntu22.iso cidata/user-data cidata/meta-data

if [ $CLEAN ]; then
    VBoxManage unregistervm $MACHINENAME
    rm -rf "${VMDIR}/$MACHINENAME/"
fi

#Create VM
echo VBoxManage createvm --name $MACHINENAME --ostype "Ubuntu22_LTS_64" --register --basefolder "${VMDIR}"
VBoxManage createvm --name $MACHINENAME --ostype "Ubuntu22_LTS_64" --register --basefolder "${VMDIR}"
sleep 2
#Set memory and network
VBoxManage modifyvm $MACHINENAME --ioapic on
sleep 2
VBoxManage modifyvm $MACHINENAME --memory 1024 --vram 128
sleep 2
VBoxManage modifyvm $MACHINENAME --nic1 bridged --bridgeadapter1 "en0: Wi-Fi (AirPort)"

#Create Disk and connect Debian Iso
rm "$VMDIR/${MACHINENAME}/${MACHINENAME}_DISK1.vdi" 
VBoxManage createhd  --filename "$VMDIR/${MACHINENAME}/${MACHINENAME}_DISK1.vdi" --size 80000 --format VDI

VBoxManage storagectl $MACHINENAME --name "SATA Controller" --add sata --controller IntelAhci
echo VBoxManage storageattach $MACHINENAME --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "${VMDIR}/${MACHINENAME}/${MACHINENAME}_DISK1.vdi"
VBoxManage storageattach $MACHINENAME --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium  "${VMDIR}/${MACHINENAME}/${MACHINENAME}_DISK1.vdi"

echo VBoxManage createhd --filename "${VMDIR}/${MACHINENAME}_DISK2.vdi" --size 80000 --format VDI
VBoxManage createhd --filename "${VMDIR}/${MACHINENAME}/${MACHINENAME}_DISK2.vdi" --size 80000 --format VDI
VBoxManage storageattach $MACHINENAME --storagectl "SATA Controller" --port 1 --device 0 --type hdd --medium  "${VMDIR}/${MACHINENAME}/${MACHINENAME}_DISK2.vdi"

echo VBoxManage createhd --filename "${VMDIR}/${MACHINENAME}_DISK3.vdi" --size 80000 --format VDI
VBoxManage createhd --filename "${VMDIR}/${MACHINENAME}/${MACHINENAME}_DISK3.vdi" --size 80000 --format VDI
VBoxManage storageattach $MACHINENAME --storagectl "SATA Controller" --port 2 --device 0 --type hdd --medium  "${VMDIR}/${MACHINENAME}/${MACHINENAME}_DISK3.vdi"


VBoxManage storagectl $MACHINENAME --name "IDE Controller" --add ide --controller PIIX4
VBoxManage storageattach $MACHINENAME --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium ${BASEDIR}/ubuntu22.iso
VBoxManage modifyvm $MACHINENAME --boot1 dvd --boot2 disk --boot3 none --boot4 none


#Enable RDP
VBoxManage modifyvm $MACHINENAME --vrde on
VBoxManage modifyvm $MACHINENAME --vrdemulticon on --vrdeport 10001
exit
#Start the VM
VBoxHeadless --startvm $MACHINENAME