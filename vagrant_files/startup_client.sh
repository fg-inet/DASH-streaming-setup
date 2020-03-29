#!/usr/bin/env bash
# shellcheck disable=SC1068
trap 'echo "# $BASH_COMMAND"' DEBUG

# Put here the IP of the interface connected to the shaping/netem host.
TEST_IF_IP="192.167.100.11"

TEST_ETH=$( ifconfig | sed -n "/addr:$TEST_IF_IP/{g;H;p};H;x" | awk '{print $1}' )

ip route add 192.167.101.0/24 via 192.167.100.12 dev $TEST_ETH
