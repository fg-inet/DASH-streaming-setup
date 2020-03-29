#!/usr/bin/env bash
trap 'echo "# $BASH_COMMAND"' DEBUG

# Put here the IP of the interfaces connected to the server and client
TEST_IF_TO_SERVER="192.167.101.12"
TEST_IF_TO_CLIENT="192.167.100.12"

TO_SERVER_ETH=$( ifconfig | sed -n "/addr:$TEST_IF_TO_SERVER/{g;H;p};H;x" | awk '{print $1}' )
TO_CLIENT_ETH=$( ifconfig | sed -n "/addr:$TEST_IF_TO_CLIENT/{g;H;p};H;x" | awk '{print $1}' )

sysctl net.ipv4.ip_forward=1

# Disable all offloading features
for eth in $TO_SERVER_ETH $TO_CLIENT_ETH
do
  for feature in "gso" "gro" "tso"
  do
    ethtool -K $eth $feature off
  done
done
