(function ($) {
  $(function () {

    var $arena = $('#arena');

    $arena.monkeyMusic({
      level: {
        units: [{
          type: 'Monkey',
          name: 'Short name #1',
          score: 125
        }, {
          type: 'Monkey',
          name: 'Long team name #2',
          score: 243
        }, {
          type: 'Monkey',
          name: 'Long team name #3',
          score: 319
        }]
      }
    });

    var socket;

    function onmessage(event) {
      var level;
      try {
        level = JSON.parse(event.data);
        $arena.monkeyArena({
          level: level
        });
      } catch (exception) {
        console.log('Failed to parse:\n' + event.data);
      }
    }

    function onclose() {
      console.log('destroying');
      $arena.monkeyArena('destroy');
    }

    function connect() {
      socket = new WebSocket('ws://localhost:3000');
      socket.onmessage = onmessage;
      socket.onopen = function () {
        console.log('Connection established.');
      };
      socket.onclose = function () {
        $arena.monkeyArena('destroy');
        console.log('No connection. Trying to reconnect...');
        setTimeout(connect, 1000);
      };
    }

    //connect();

  });
}(jQuery));
