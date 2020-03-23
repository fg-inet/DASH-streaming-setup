num_runs=25

HomeDir='/home/vagrant/ChromeStuff'
VideoDir='bbb/playlist.mpd'
Host='localhost'


sleep 10


for run in $(eval echo {1..$num_runs});do
	echo "new_run"
	npm start $HomeDir $run $VideoDir $Host
	wait
	sleep 10
	
done	

