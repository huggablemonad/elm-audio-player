'use strict';

var node = document.getElementById('main');
var app = Elm.Main.embed(node);

var audio = (function() {
  var playlist = null;
  var index = 0;

  function init(tracks) {
    Howler.unload();
    Howler.volume(0.5);
    playlist = Array.prototype.map.call(tracks,
        song => new Howl({
            src: song,
            html5: true,
            onplay: playEvent,
            onpause: pauseEvent,
            onstop: stopEvent,
        }));
  }

  function play(trackId) {
    index = trackId;
    playlist[trackId].play();
  }

  function pause(trackId) {
    playlist[trackId].pause();
  }

  function stop(trackId) {
    playlist[trackId].stop();
  }

  function stopAndPlay(trackIds) {
    var [currentTrackId, nextTrackId] = trackIds;
    index = nextTrackId;

    playlist[currentTrackId].stop();
    playlist[nextTrackId].play();
  }

  function seek(trackId) {
    app.ports.seekPos.send(playlist[trackId].seek());
  }

  function seekTo(trackAndPos) {
    var [trackId, pos] = trackAndPos;

    playlist[trackId].seek(pos);
  }

  function volume(vol) {
    Howler.volume(vol);
  }

  function playEvent(soundId) {
    app.ports.playEvent.send(playlist[index].duration());
  }

  function pauseEvent(soundId) {
    app.ports.pauseEvent.send(null);
  }

  function stopEvent(soundId) {
    app.ports.stopEvent.send(null);
  }

  return {
    init: init,
    play: play,
    pause: pause,
    stop: stop,
    stopAndPlay: stopAndPlay,
    seek: seek,
    seekTo: seekTo,
    volume: volume,
  }
})();

app.ports.init.subscribe(function(tracks) {
  audio.init(tracks);
});

app.ports.play.subscribe(function(trackId) {
  audio.play(trackId);
});

app.ports.pause.subscribe(function(trackId) {
  audio.pause(trackId);
});

app.ports.stop.subscribe(function(trackId) {
  audio.stop(trackId);
});

app.ports.stopAndPlay.subscribe(function(trackIds) {
  audio.stopAndPlay(trackIds);
});

app.ports.seek.subscribe(function(trackId) {
  audio.seek(trackId);
});

app.ports.seekTo.subscribe(function(trackAndPos) {
  audio.seekTo(trackAndPos);
});

app.ports.volume.subscribe(function(vol) {
  audio.volume(vol);
});
