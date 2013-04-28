(function ($) {
  $(function () {

    var socket;
    var $arena = $('#arena');
    var isPlaying = false;

    function onmessage(event) {
      var level;
      try {
        level = JSON.parse(event.data);
        if (isPlaying) {
          // TODO        
        } else {
          isPlaying = true;
          $('body').addClass('playing');
          $arena.monkeyMusic({
            level: level
          });
        }
        //if (isPlaying) {
          //// Perform update if game is on
          //$arena.monkeyMusic('update', level);
        //} else {
          //// Perform initialization if no game
          //$arena.monkeyMusic({
            //level: level
          //});
          //$('body').addClass('playing');
          //isPlaying = true;
        //}
      } catch (exception) {
        console.log('Failed to parse:\n' + event.data);
      }
    }

    function connect() {
      socket = new WebSocket('ws://localhost:3000');
      socket.onmessage = onmessage;
      socket.onopen = function () {
        console.log('Connection established.');
      };
      socket.onclose = function () {
        if (isPlaying) {
          console.log('destroying');
          $arena.monkeyMusic('destroy');
          $('body').removeClass('playing');
          isPlaying = false;
        }
        console.log('No connection. Trying to reconnect...');
        setTimeout(connect, 1000);
      };
    }

    connect();

  });
}(jQuery));
