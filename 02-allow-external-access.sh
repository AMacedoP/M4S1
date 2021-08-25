#!/bin/bash

WORKER1=10.60.1.2
WORKER2=10.60.2.2

# Run only in master, port forwarding for VNC ports in WORKERS
sudo iptables -t nat -A PREROUTING -p tcp -i ens3 --dport 5900 -j DNAT --to-destination ${WORKER1}:5900
sudo iptables -t nat -A PREROUTING -p tcp -i ens3 --dport 5902 -j DNAT --to-destination ${WORKER1}:5902
sudo iptables -t nat -A PREROUTING -p tcp -i ens3 --dport 5905 -j DNAT --to-destination ${WORKER2}:5905
sudo iptables -t nat -A PREROUTING -p tcp -i ens3 --dport 5903 -j DNAT --to-destination ${WORKER2}:5903

