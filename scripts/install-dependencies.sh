#!/bin/bash

# Update and upgrade system packages
sudo apt update
sudo apt upgrade -y

# Install qemu/kvm for virtualization
sudo apt install -y qemu-kvm bridge-utils

# Install openvswitch for switching 
sudo apt install -y openvswitch-switch

