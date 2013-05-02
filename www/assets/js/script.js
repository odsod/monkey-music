(function ($) {
  $(function () {

    var
      socket,
      $body = $('body'),
      $level = $('#level'),
      $scoreboard = $('#scoreboard'),
      isPlaying = false;

    function onmessage(event) {
      var level = JSON.parse(event.data);
      if (!isPlaying) {
        $body.addClass('playing');
        $level.monkeyMusicLevel(level);
        $scoreboard.monkeyMusicScoreboard(level);
        isPlaying = true;
      }
    }

    function onclose() {
      if (isPlaying) {
        $scoreboard.monkeyMusicScoreboard('destroy');
        $level.monkeyMusicLevel('destroy');
        $body.removeClass('playing');
        isPlaying = false;
      }
      console.log('No connection. Trying to reconnect...');
      setTimeout(connect, 1000);
    }

    function connect() {
      socket = new WebSocket('ws://localhost:3000');
      socket.onmessage = onmessage;
      socket.onclose = onclose;
      socket.onopen = function () {
        console.log('Connection established.');
      };
    }

    connect();

  });
}(jQuery));
