var monkeymusic = monkeymusic || {};

monkeymusic.level = (function (createjs, tween, window) {

  /* Settings */
  createjs.Ticker.setFPS(60);
  createjs.useRAF = true;

  var
    stage;

  function initStage(canvas, level) {
    stage = new createjs.Stage(canvas);
    createjs.Ticker.addEventListener('tick', stage);
    canvas.width = level.width * monkeymusic.constants.UNIT_WIDTH;
    canvas.height = level.height * monkeymusic.constants.UNIT_HEIGHT;
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
    var monkey = monkeymusic.sprites.Basket();
    stage.addChild(monkey);
    monkey.gotoAndPlay('default');
    //tween.get(monkey).to({
      //x: 300
    //}, 2000);
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