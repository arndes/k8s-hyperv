#!/bin/bash

export IPADDR=$1
export GATEWAY=$2

# network configuration
echo "\
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: false
      addresses: [$IPADDR]
      dhcp6: false
      optional: true
      nameservers:
        addresses: [4.2.2.1, 4.2.2.2, 208.67.220.220]
      routes:
      - to: default
        via: $GATEWAY" | envsubst '$IPADDR' > /etc/netplan/01-netcfg.yaml

netplan apply
