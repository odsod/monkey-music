var monkeymusic = (function (document) {

  var constants = {
    UNIT_WIDTH: 70,
    UNIT_HEIGHT: 70
  };

  var
    socket,
    canvas,
    isPlaying = false;

  function onmessage(event) {
    var level = JSON.parse(event.data);
    if (!isPlaying) {
      monkeymusic.level.init(canvas, level);
      isPlaying = true;
    } else {
      monkeymusic.level.update(level);
    }
  }

  function onclose() {
    if (isPlaying) {
      monkeymusic.level.destroy();
      isPlaying = false;
    }
    console.log('No connection. Trying to reconnect...');
    setTimeout(connect, 10);
  }

  function connect() {
    socket = new WebSocket('ws://localhost:3000');
    socket.onmessage = onmessage;
    socket.onclose = onclose;
    socket.onopen = function () {
      console.log('Connection established.');
    };
  }

  function init() {
    canvas = document.getElementById('canvas');
    connect();
  }

  return {
    init: init,
    constants: constants
  };

}(document));
