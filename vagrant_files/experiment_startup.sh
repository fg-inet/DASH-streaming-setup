browserDir='/home/vagrant/BrowserDir'
host='192.167.101.13'
#specify the number of runs to be performed per measurement
num_runs = 3
vid_timeout = '1500s'
for i in {1..$num_runs}
do
	videoDirNA='CBR_TOS_NA_10/playlist.mpd'
	videoDirVAR='CBR_TOS_VAR_10/playlist.mpd'
	trace_folder='tos_trace'
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
		vagrant ssh client -- -t "(cd /home/vagrant/DASH-setup/client && timeout $vid_timeout npm start $browserDir $run_var $videoDirVAR $host)"
		sleep 5
		# do the same for NA video 
		vagrant ssh netem -- -t bash trace_killer.sh 
		sleep 1
		vagrant ssh netem -- -t timeout $vid_timeout bash netem_start_trace.sh trace_files/$trace_folder/$tr &
		sleep 1
		vagrant ssh client -- -t "(cd /home/vagrant/DASH-setup/client && timeout $vid_timeout npm start $browserDir $run_var $videoDirNA $host)"
		sleep 5

	done
    #Big Buck Bunny
	VideoDirNA='CBR_BBB_NA_10/playlist.mpd'
	VideoDirVAR='CBR_BBB_VAR_10/playlist.mpd'
	trace_folder='bbb_trace'

	traces=( $(ls trace_files/$trace_folder) )
	for tr in "${traces[@]}"
	do 
 		echo $tr
		run_var="trace_"$tr"_run"$i
		#kill old trace sricpts 
		vagrant ssh netem -- -t bash trace_killer.sh 
		sleep 1
		vagrant ssh netem -- -t timeout $vid_timeout bash netem_start_trace.sh trace_files/$trace_folder/$tr &
		sleep 1
		#npm command needs to run in in the fetcher folder!
		vagrant ssh client -- -t "(cd /home/vagrant/DASH-setup/client && timeout $vid_timeout npm start $browserDir $run_var $videoDirVAR $host)"
		sleep 5
		# do the same for NA video 
		vagrant ssh netem -- -t bash trace_killer.sh 
		sleep 1
		vagrant ssh netem -- -t timeout $vid_timeout bash netem_start_trace.sh trace_files/$trace_folder/$tr &
		sleep 1
		vagrant ssh client -- -t "(cd /home/vagrant/DASH-setup/client && timeout $vid_timeout npm start $browserDir $run_var $videoDirNA $host)"
		sleep 5

	done  


done

