#! /bin/bash

name="$1"

if [ -z $name ] ; then
  echo "Usage : kvm-build.sh <name>"
  exit 2
fi

classes="$2"

if [ -z $classes ] ; then
	classes="DEBIAN,AMD64"
fi

if [ -f /var/lib/libvirt/images/$name.qcow2 ] ; then
  echo "$name already exists in kvm"
  exit 2;
fi

fai-diskimage -Nvu $name -S5G -c$classes /opt/fai/$name.vdi

qemu-img convert -f vdi -O qcow2 /opt/fai/$name.vdi /var/lib/libvirt/images/$name.qcow2

virt-install \
	--connect qemu:///system \
	--ram 1024 \
	-n $name \
	-r 2048 \
	--os-type=linux \
	--os-variant=generic \
	--disk path=/var/lib/libvirt/images/$name.qcow2,device=disk,format=qcow2 \
	--vcpus=1 \
	--vnc \
	--noautoconsole \
	--import

rm -f /opt/fai/$name.vdi

virsh autostart $name

virsh dominfo $name