#!/bin/bash

# Delete all elements created
sudo killall qemu-system-x86_64

sudo ip link delete group 10

for i in $(sudo ovs-vsctl list-br); do
	sudo ovs-vsctl del-br ${i}
done

sudo rm -rf ~/images
