#We do three runs with exact same config (trace type, trace num, trace sp)
HomeDir='/home/vagrant/ChromeStuff'
Host='192.167.101.13'

for i in {1..1}
do
	#Tears of Steel
	VideoDirNA='CBR_TOS_NA_10/playlist.mpd'
	VideoDirVAR='CBR_TOS_VAR_10/playlist.mpd'
	trace_folder='tos_trace_2'

	traces=( $(ls trace_files/$trace_folder) )
	for tr in "${traces[@]}"
	do 
 		echo $tr
		run_var="trace_"$tr"_run"$i
		# let the netem begin! 
		# do it all for VAR video 
		vagrant ssh netemLogger1 -- -t bash trace_killer.sh 
		sleep 1
		vagrant ssh netemLogger1 -- -t timeout 1500s bash netem_start_trace.sh trace_files/$trace_folder/$tr &
		sleep 1
		vagrant ssh client1 -- -t "(cd /home/vagrant/DASHStreamExample/fetcher && timeout 1500s npm start $HomeDir $run_var $VideoDirVAR $Host)"
		sleep 5
		# do the same for NA video 
		vagrant ssh netemLogger1 -- -t bash trace_killer.sh 
		sleep 1
		vagrant ssh netemLogger1 -- -t timeout 1500s bash netem_start_trace.sh trace_files/$trace_folder/$tr &
		sleep 1
		vagrant ssh client1 -- -t "(cd /home/vagrant/DASHStreamExample/fetcher && timeout 1500s npm start $HomeDir $run_var $VideoDirNA $Host)"
		sleep 5

	done
    #Big Buck Bunny
	VideoDirNA='CBR_BBB_NA_10/playlist.mpd'
	VideoDirVAR='CBR_BBB_VAR_10/playlist.mpd'
	trace_folder='bbb_trace_2'

	traces=( $(ls trace_files/$trace_folder) )
	for tr in "${traces[@]}"
	do 
 		echo $tr
		run_var="trace_"$tr"_run"$i
		#kill old trace sricpts 
		vagrant ssh netemLogger1 -- -t bash trace_killer.sh 
		sleep 1
		vagrant ssh netemLogger1 -- -t timeout 15000s bash netem_start_trace.sh trace_files/$trace_folder/$tr &
		sleep 1
		#npm command needs to run in in the fetcher folder!
		vagrant ssh client1 -- -t "(cd /home/vagrant/DASHStreamExample/fetcher && timeout 1500s npm start $HomeDir $run_var $VideoDirVAR $Host)"
		sleep 5
		# do the same for NA video 
		vagrant ssh netemLogger1 -- -t bash trace_killer.sh 
		sleep 1
		vagrant ssh netemLogger1 -- -t timeout 1500s bash netem_start_trace.sh trace_files/$trace_folder/$tr &
		sleep 1
		vagrant ssh client1 -- -t "(cd /home/vagrant/DASHStreamExample/fetcher && timeout 1500s npm start $HomeDir $run_var $VideoDirNA $Host)"
		sleep 5

	done  


done

