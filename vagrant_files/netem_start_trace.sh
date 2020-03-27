bandwidth_trace=$1

readarray -t bw_vals < $bandwidth_trace

sleep 1

sudo tc qdisc del dev eth2 root
sudo tc qdisc add dev eth2 root handle 1: htb default 1
sudo tc class add dev eth2 parent 1: classid 1:1 htb rate 1000kbit

for line in "${bw_vals[@]}"; do
	sudo tc class change dev eth2 parent 1: classid 1:1 htb rate "$line"kbit
	sleep 1
done
