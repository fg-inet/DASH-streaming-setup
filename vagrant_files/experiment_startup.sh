#!/bin/bash

browserDir='/home/vagrant/browserDir'
host='192.167.101.13'
#specify the number of runs to be performed per measurement
num_runs=2
vid_timeout=1200
for i in $( seq 1 $num_runs )
do
	videoDirNA='CBR_BBB_VAR_10/playlist.mpd'
	videoDirVAR='CBR_BBB_VAR_10/playlist.mpd'
	trace_folder='test_traces'
	#itreate over all traces in the specified trace folder
	traces=( $(ls trace_files/$trace_folder) )
	for tr in "${traces[@]}"
	do 
 		echo $tr
		run_var="trace_"$tr"_run"$i
		#measurements for the video variably encoded 
		vagrant ssh netem -- -t bash trace_killer.sh 
		sleep 1
		#start the new trace
		vagrant ssh netem -- -t timeout $vid_timeout bash netem_start_trace.sh trace_files/$trace_folder/$tr &
		sleep 1
		#start the measurement at the client
		vagrant ssh client -- -t "(cd /home/vagrant/DASH-setup-local && timeout $vid_timeout npm start $browserDir $run_var $videoDirVAR $host)"
		sleep 5
		# do the same for NA video 
		vagrant ssh netem -- -t bash trace_killer.sh 
		sleep 1
		vagrant ssh netem -- -t timeout $vid_timeout bash netem_start_trace.sh trace_files/$trace_folder/$tr &
		sleep 1
		vagrant ssh client -- -t "(cd /home/vagrant/DASH-setup-local && timeout $vid_timeout npm start $browserDir $run_var $videoDirNA $host)"
		sleep 5

	done
done

