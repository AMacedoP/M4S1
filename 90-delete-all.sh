#!/bin/bash

WORKER1=192.168.10.2
WORKER2=192.168.20.2

SCRIPT=./scripts/delete-all.sh

# Delete all elements
ssh ${WORKER1} "bash -s" < ${SCRIPT}
ssh ${WORKER2} "bash -s" < ${SCRIPT}

bash ${SCRIPT}

# Delete port forward
sudo iptables -t nat -D PREROUTING -p tcp -i ens3 --dport 5900 -j DNAT --to-destination ${WORKER1}:5900
sudo iptables -t nat -D PREROUTING -p tcp -i ens3 --dport 5902 -j DNAT --to-destination ${WORKER1}:5902
sudo iptables -t nat -D PREROUTING -p tcp -i ens3 --dport 5905 -j DNAT --to-destination ${WORKER2}:5905
sudo iptables -t nat -D PREROUTING -p tcp -i ens3 --dport 5903 -j DNAT --to-destination ${WORKER2}:5903
