num_runs=10

HomeDir='/home/vagrant/ChromeStuff'
VideoDir='CBR_BBB_VAR_10/playlist.mpd'
Host='192.167.101.13'



sleep 10


for run in $(eval echo {1..$num_runs});do
	echo "new_run"
	run_var="fix_3c0__"$run
	npm start $HomeDir $run_var $VideoDir $Host

	wait
	sleep 10
	
done	
