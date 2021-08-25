#!/bin/bash

# Variables
WORKER1=10.60.1.2
WORKER2=10.60.2.2

# First install in master
bash ./scripts/start-vm-master.sh

# Install in workers
ssh ${WORKER1} "bash -s" < ./scripts/start-vm-worker1.sh
ssh ${WORKER2} "bash -s" < ./scripts/start-vm-worker2.sh
