# DASH-streaming-setup
Setup used for the video streaming experiments in the MMSys'20 Paper "Comparing Fixed and Variable Segment Durations for Adaptive Video Streaming – A Holistic Analysis". 
## Overview 
The setup consists of three virtual machines. 
   * The __server__, which hosts the video content 
   * The __netem__, which throttles the bandwidth, as for example defined by traces 
   * The __client__, which uses DASH.js to stream the video
   
![](images/setup.JPG)



## Using the setup for video streaming measurements 
__Step 1__ Open a terminal and navigate into the subfolder *vagrant_files*. Run the following command to provision all VMs (this might take a few minutes).
```
vagrant up
```
All VMs are ready as soon as you can see the following output: 
```
[nodemon] starting node ./bin/www
```

__Step 2__ Open a second terminal and navigate again into the subfolder *vagrant_files* 

   * __To perform a single measurement run__: Log in to the client VM by typing the following command: 
```
   vagrant ssh client 
```   
On the client VM, change the directory using 
```
cd /home/vagrant/DASH-setup/fetcher
```
In this directory, a measurment run can be initiated with the following command: 
```
npm start $browserDIr $run_var $videoDir $host
```
With the parameters being as follows. 
   * browserDir: A directory located at the client, where Chrome settings and log files are stored
   * run_var: A unique name for the experiment run
   * videoDir: Server-sided path for video to be streamed 
   * host: IP address of the server
Then, a single run can for exmaple be initiated as follows: 
npm start $browserDIr $run_var $videoDir $host
```
npm start '/home/vagrant/BrowserDir' 'test_run' 'CBR_BBB_NA_10/playlist.mpd' '192.167.101.13'
```   

   * __For a set of measurement runs using the automation script__: Run the following commands to start the measurements. 
    ```
    bash experiment_startup.sh
    ```


__Step 3__ As soon as a measurment run is finished, the log file can be found in the following directory: *DASH-setup/client/logs*. 

## Detailed description of the functionalities

### Client

### Netem 

### Server 

## Customizing the setup 
We describe in the following, how the setup can be customized. 
### ABR and buffer thresholds
To adapt ABR and buffer thresholds, navigate to *DASH-setup/server/public/javascripts*. Open the file *player.js* to modify the parameters in line 20: 
```
player.updateSettings({'streaming': {stableBufferTime: 30, bufferTimeAtTopQuality: 45, abr:{ABRStrategy: 'abrDynamic'}}});
```
DASH.js provides three different ABR Strategies: 
  * abrDynamic (default, hybrid solution)
  * abrBolda (buffer-based)
  * abrThroughput (rate-based)
  
Please find more information regarding different buffer threshold settings and other player/ABR settings here: http://cdn.dashjs.org/latest/jsdoc/module-Settings.html#~StreamingSettings__anchor

### Using own bandwidth traces or videos
  * Traces: The automation srcipt *experiment_startup.sh* considers all available traces for a specific video. Hence, if measurements should be run with a specific set of traces, these traces simply need to be put into the respective directory here: *vagrant_files/trace_files*.
  * Videos: All test videos, which are located in the folder *DASH-setup/public/videos*, will be available for streaming at the server. In our setup, we used the following structure for the video sequences. 
```
videos
|
|_____CBR_BBB_VAR_10
|     |     playlist.mpd
|     |_____quality_0
|     |     |     quality0.mpd
|     |     |     init_stream0.m4s
|     |     |     chunk1.m4s
|     |     |     chunk2.m4s
|     |     |     chunk3.m4s
|     |       
|     |_____quality_1
|     |     |     quality1.mpd
|     |     |     init_stream1.m4s
|     |     |     chunk1.m4s
|     |     |     chunk2.m4s
|     |     |     chunk3.m4s
|     |
|     |_____quality_2
|     |     |     quality2.mpd
|     |     |     init_stream2.m4s
|     |     |     chunk1.m4s
|     |     |     chunk2.m4s
|     |     |     chunk3.m4s
|
|_____CBR_BBB_NA_10
|     |     playlist.mpd
|     |_____quality_0
|     |     |     quality0.mpd
|     |     |     init_stream0.m4s
|     |     |     chunk1.m4s
|     |     |     chunk2.m4s
|     |     |     chunk3.m4s
|     |       
|     |_____quality_1
|     |     |     quality1.mpd
|     |     |     init_stream1.m4s
|     |     |     chunk1.m4s
|     |     |     chunk2.m4s
|     |     |     chunk3.m4s
|     |
|     |_____quality_2
|     |     |     quality2.mpd
|     |     |     init_stream2.m4s
|     |     |     chunk1.m4s
|     |     |     chunk2.m4s
|     |     |     chunk3.m4s

```
  
  
  * Using own video: 
  * Changing the heuristic
  * Own traces 
  * Using a fixed bandwidth


## Evaluating QoE from Log Files 

## Links/References
  * The measurements are performed using the DASH reference client implementation DASH.js https://github.com/Dash-Industry-Forum/dash.js?
  * Puppeteer was used to allow the usage of DASH.js within the Chrome Browser in headless mode https://github.com/puppeteer/puppeteer
  * The QoE is evaluated according to the standardized ITU-T P.1203 model https://github.com/itu-p1203/itu-p1203
