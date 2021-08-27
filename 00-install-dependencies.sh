#!/bin/bash

# Variables
WORKER1=192.168.10.2
WORKER2=192.168.20.2

SCRIPT=./scripts/install-dependencies.sh

# First install in master
bash ${SCRIPT}

# Install in workers
ssh ${WORKER1} "bash -s" < ${SCRIPT}
ssh ${WORKER2} "bash -s" < ${SCRIPT}
