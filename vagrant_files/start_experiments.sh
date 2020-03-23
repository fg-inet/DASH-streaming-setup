bandwidth_trace='network_trace0'
num_runs=25
num_vals=600

readarray -t bw_vals < $bandwidth_trace
echo ${bw_vals[@]}
echo lalal
#bw_vals+=("${bw_vals[@]}")
#shuffled=( $(shuf -e "${bw_vals[@]}") )
#echo ${shuffled[@]}

sleep 10

for run in `eval echo {1..$num_runs}`;do
        shuffled=( $(shuf -e "${bw_vals[@]}") )
        echo ${shuffled[@]}
        > netem_log/run_$run
        echo "new run"
        sudo tc qdisc del dev eth2 root
        sudo tc qdisc add dev eth2 root handle 1: htb default 1
        sudo tc class add dev eth2 parent 1: classid 1:1 htb rate 645kbit
        rand1=$(shuf -i 1-299 -n 1)
        rand2=$(($rand1 + 300))
        for line in "${shuffled[@]}"; do
        #for i in `eval echo {$rand1..$rand2}`;do
                #sudo tc class change dev eth2 parent 1: classid 1:1 htb rate "$line"kbit
                #line="${shuffled[$i]}"
                sudo tc class change dev eth2 parent 1: classid 1:1 htb rate "$line"kbit
                #date +%s >> netem_log/run_$run 
                echo -n $line";" >> netem_log/run_$run
                date +%s%3N >> netem_log/run_$run
                sleep 1
        done
        sleep 158.5
done
