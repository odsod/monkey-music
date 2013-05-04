window.monkeymusic = (function (document) {

  function init() {
    var canvas = document.getElementById('canvas');
    monkeymusic.level.init(canvas, { width: 10, height: 10 });
  }

  return {
    init: init
  };

}(document));
