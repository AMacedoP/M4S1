#!/bin/bash

# Variables
WORKER1=10.60.1.2
WORKER2=10.60.2.2

SCRIPT=./scripts/install-dependencies.sh

# First install in master
bash ${SCRIPT}

# Install in workers
ssh ${WORKER1} "bash -s" < ${SCRIPT}
ssh ${WORKER2} "bash -s" < ${SCRIPT}
