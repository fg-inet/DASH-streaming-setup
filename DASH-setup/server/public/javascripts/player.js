const intervalLength = 100; // in ms
const initialBufferLevel = 12;
let player = dashjs.MediaPlayer().create();	 
let qualityLog = [];
let stallLog = [];
let segmentLog = [];
let metricInterval;
let isPlaying = 0;
let initialStart = true;
let fragmentStart;
let fragmentEnd;

function getUrlParameter(name) {
  name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
  let regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
  let results = regex.exec(location.search);
  return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
}
window.onload = function () {
  let videoUrl = "/video/" + getUrlParameter('vid');
  player.updateSettings({'streaming': {stableBufferTime: 30}});
  player.initialize(document.querySelector("#videoPlayer"), videoUrl, false);
  let initMetric = {
    timeStamp: Date.now(),
    isPlaying: 0
  };
  stallLog.push(initMetric);
  
  
  metricInterval = setInterval(function () {
    //let playerMetric = player.getMetricsFor('video');
    let dashMetrics = player.getDashMetrics();
    let metric = {
      timeStamp: Date.now(),
      bufferLevel: dashMetrics.getCurrentBufferLevel('video'),
      qualityLevel: player.getQualityFor("video"),
      playedTime: dashMetrics.getCurrentDVRInfo('video').time
    };
    if(metric.bufferLevel >= initialBufferLevel && initialStart){
      player.play();
      isPlaying = 1;
      initialStart = false;
    }
    qualityLog.push(metric);
  }, intervalLength)
};
player.on("fragmentLoadingStarted", function () {
    fragmentStart = Date.now();
});
player.on("fragmentLoadingCompleted", function (data) {
  fragmentEnd = Date.now(); 
  let metric = {
    segmentIndex: data.request.index,
    segmentSize: data.request.bytesTotal,
    downloadStart: fragmentStart,
    downloadTime: fragmentEnd - fragmentStart
  };
  segmentLog.push(metric);
});
player.on("playbackPlaying", function () {
  let metric = {
    timeStamp: Date.now(),
    isPlaying: 1
  };
  stallLog.push(metric);
});

player.on("bufferLoaded" && "canPlay", function () {
  //player.play();
  //isPlaying = 1;
});

player.on("playbackWaiting", function () {
  let metric = {
    timeStamp: Date.now(),
    isPlaying: 0
  };
  stallLog.push(metric);
  });
player.on("playbackStalled", function () {
  console.log("isStalled")
});

player.on("playbackEnded", function () {
	clearInterval(metricInterval);
});

