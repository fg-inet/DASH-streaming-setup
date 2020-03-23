# DASH-streaming-setup
Setup used for the video streaming experiments in the MMSys'20 Paper "Comparing Fixed and Variable Segment Durations for Adaptive Video Streaming – A Holistic Analysis". It consists of three virtual machines. 
   * The __server__:, which hosts the video content 
   * The __netem__:, which throttles the bandwidth, as for example defined by traces 
   * The __client__:, which uses DASH.js to stream the video
![](images/setup.JPG)
