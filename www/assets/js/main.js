var monkeymusic = (function (document) {

  var constants = {
    UNIT_WIDTH: 70,
    UNIT_HEIGHT: 70
  };

  function init() {
    var canvas = document.getElementById('canvas');
    monkeymusic.level.init(canvas, { width: 10, height: 10 });
  }

  return {
    init: init,
    constants: constants
  };

}(document));
