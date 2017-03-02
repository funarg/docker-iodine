#!/bin/sh

#set -e

TUNNEL_IP=${IODINE_TUNNEL_IP:-"10.10.10.1"}

#sysctl -w net.ipv4.ip_forward=1
iptables -t nat -D POSTROUTING -s 10.10.10.0/24 -o br0 -j MASQUERADE
iptables -t nat -D POSTROUTING -s 10.10.10.0/24 -o br0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.10.10.0/24 -o br0 -j MASQUERADE

iptables -S
iptables -S -t nat

iodined -c -m 1280 -DD -f $TUNNEL_IP $IODINE_HOST -P $IODINE_PASSWORD -p $PORT -n $EXTERNAL_IP
