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
All VMs are ready as soon as you can see the following 
__Step 2__ 

## Detailed description of the functionalities


## Links/References
  * The measurements are performed using the DASH reference client implementation DASH.js https://github.com/Dash-Industry-Forum/dash.js?
  * Puppeteer was used to allow the usage of DASH.js within the Chrome Browser in headless mode https://github.com/puppeteer/puppeteer
  * The QoE is evaluated according to the standardized ITU-T P.1203 model https://github.com/itu-p1203/itu-p1203
