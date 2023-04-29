#!/bin/bash

sudo ovs-vsctl add-br br1

sudo ifconfig br1 192.168.10.2/24 up

sudo ip link add v0 type veth peer name v1

sudo ip link set v1 up

sudo ovs-vsctl add-port br1 v1

sudo ovs-vsctl add-port br1 vxlan0 -- set interface vxlan0 type=vxlan options:remote_ip=192.168.159.129 options:key=10

sudo ip netns add ns1

sudo ip link set v0 netns ns1

sudo ip netns exec ns1 ifconfig v0 192.168.10.10/24 up

sudo ip netns exec ns1 ip route add default via 192.168.10.2

sudo ip route add 192.168.11.0/24 via 192.168.159.129
