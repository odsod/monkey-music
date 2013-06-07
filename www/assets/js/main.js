var monkeymusic = (function (document) {

  var constants = {
    UNIT_WIDTH: 64,
    UNIT_HEIGHT: 64
  };

  var
    socket,
    canvas,
    isPlaying = false,
    doCleanup = false;

  function onmessage(event) {
    var level = JSON.parse(event.data);
    if (doCleanup) {
      cleanup();
      doCleanup = false;
    }
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

  function cleanup() {
    monkeymusic.level.destroy();
    monkeymusic.sprites.reset();
    $('body').removeClass('playing');
    $('#scores').scoreboard('destroy');
  }

  function onclose() {
    if (isPlaying) {
      doCleanup = true;
      isPlaying = false;
    }
    console.log('No connection. Trying to reconnect...');
    setTimeout(connect, 10);
  }

  function connect() {
    socket = new WebSocket('ws://10.211.55.4:3000');
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
