#!/bin/bash

start_vm () {
	NAME=$1
	VNC_PORT=$2

	# Generate random MAC
	MAC=$(printf '00:60:2f:%02x:%02x:%02x' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])

	# Create TAP for VM
	sudo ip tuntap add name ${NAME} mode tap
	sudo ip link set up ${NAME}
	sudo ip link set dev ${NAME} group 10

	# Create img from qcow2 backing image
	qemu-img create -f qcow2 -o backing_file=~/images/cirros-base.qcow2 ~/images/${NAME}.qcow2

	# Start virtual machine
	sudo qemu-system-x86_64 -enable-kvm -cpu host -m 512 -smp 1 -vnc 0.0.0.0:${VNC_PORT} -name ${NAME} \
	        -netdev tap,id=id_${NAME},ifname=${NAME},script=no,downscript=no \
		-device e1000,netdev=id_${NAME},mac=${MAC} -daemonize ~/images/${NAME}.qcow2
}

# Download CirrOS image
curl -sL http://download.cirros-cloud.net/0.5.1/cirros-0.5.1-x86_64-disk.img -o ~/images/cirros-base.qcow2 --create-dirs

# Create both switches
N1=NET3
N2=NET2

sudo ovs-vsctl add-br ${N1}
sudo ovs-vsctl add-br ${N2}

# Create both VMs
VM1=${N1}VM2
VM2=${N2}VM2

start_vm ${VM1} 5
start_vm ${VM2} 3

# Attach both taps to VM
sudo ovs-vsctl add-port ${N1} ${VM1}
sudo ovs-vsctl add-port ${N2} ${VM2}
