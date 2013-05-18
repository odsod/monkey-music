var monkeymusic = (function (document) {

  var constants = {
    UNIT_WIDTH: 64,
    UNIT_HEIGHT: 64
  };

  var
    socket,
    canvas,
    isPlaying = false;

  function onmessage(event) {
    var level = JSON.parse(event.data);
    if (!isPlaying) {
      monkeymusic.level.init(canvas, level);
      $('body').addClass('playing');
      $('#scores').scoreboard(level);
      isPlaying = true;
    } else {
      monkeymusic.level.update(level);
      $('#scores').scoreboard(level);
    }
  }

  function onclose() {
    if (isPlaying) {
      monkeymusic.level.destroy();
      isPlaying = false;
      $('body').removeClass('playing');
      $('#scores').scoreboard('destroy');
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
