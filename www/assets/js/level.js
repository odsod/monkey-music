window.monkeymusic = window.monkeymusic || {};

window.monkeymusic.level = (function (createjs, tween, window) {

  /* Constants */
  var
    UNIT_WIDTH = 70,
    UNIT_HEIGHT = 70;

  /* Settings */
  createjs.Ticker.setFPS(60);
  createjs.useRAF = true;

  var
    stage;

  var spriteSheets = {
    'Monkey': (function () {
      return new createjs.SpriteSheet({
        images: ['assets/img/monkey.png'],
        frames: { width: UNIT_WIDTH, height: UNIT_HEIGHT },
        animations: {
          run: [3, 5, 'run', 8],
          stand: [6, 7, 'stand', 16]
        }
      });
    }())
  };

  var sprites = {
    'Monkey': function () {
      return new createjs.BitmapAnimation(spriteSheets.Monkey);
    },
  };

  function initStage(canvas, level) {
    stage = new createjs.Stage(canvas);
    canvas.width = level.width * UNIT_WIDTH;
    canvas.height = level.height * UNIT_HEIGHT;
    window.onresize = resizeCanvas;
    resizeCanvas();
  }

  function resizeCanvas() {
    var
      canvas = stage.canvas,
      canvasStyle = canvas.style,
      canvasWidth = canvas.width,
      canvasHeight = canvas.height,
      windowWidth = window.innerWidth,
      windowHeight = window.innerHeight,
      scaleToFitX = windowWidth / canvasWidth,
      scaleToFitY = windowHeight / canvasHeight,
      scale = Math.min(scaleToFitX, scaleToFitY),
      newHeight = canvasHeight * scale,
      newWidth = canvasWidth * scale;
    // Scale canvas
    canvasStyle.width = newHeight + 'px';
    canvasStyle.height = newWidth + 'px';
    // Center canvas
    canvasStyle.marginTop = (windowHeight - newHeight) / 2;
    canvasStyle.marginLeft = (windowWidth - newWidth) / 2;
  }

  function init(canvas, level) {
    initStage(canvas, level);
    createjs.Ticker.addEventListener('tick', stage);
    var monkey = sprites.Monkey();
    stage.addChild(monkey);
    monkey.gotoAndPlay('run');
  }

  function update(level) {
  }

  function destroy() {
    // Reset ticker
    createjs.Ticker.init();
    // Reset stage
    stage.clear();
    stage.removeAllChildren();
  }

  return {
    init: init,
    update: update,
    destroy: destroy
  };

}(createjs, createjs.Tween, window));
