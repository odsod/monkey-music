(function ($) {
  $(function () {

    var $body = $('#arena');

    var socket;

    function onmessage(event) {
      var level;
      try {
        level = JSON.parse(event.data);
        $body.monkeyArena({
          level: level
        });
      } catch (exception) {
        console.log('Failed to parse:\n' + event.data);
      }
    }

    function onclose() {
      console.log('destroying');
      $body.monkeyArena('destroy');
    }

    function connect() {
      socket = new WebSocket('ws://localhost:3000');
      socket.onmessage = onmessage;
      socket.onopen = function () {
        console.log('Connection established.');
      };
      socket.onclose = function () {
        $body.monkeyArena('destroy');
        console.log('No connection. Trying to reconnect...');
        setTimeout(connect, 1000);
      };
    }

    connect();

  });
}(jQuery));
