var monkeymusic = monkeymusic || {};

monkeymusic.level = (function (createjs, tween, window) {

  /* Settings */
  createjs.Ticker.setFPS(60);
  createjs.useRAF = true;

  var
    stage,
    units;

  function initStage(canvas, level) {
    stage = new createjs.Stage(canvas);
    createjs.Ticker.addEventListener('tick', stage);
    canvas.width = level.width * monkeymusic.constants.UNIT_WIDTH;
    canvas.height = level.height * monkeymusic.constants.UNIT_HEIGHT;
    console.log(canvas.width, canvas.height);
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
    //canvasStyle.width = newHeight + 'px';
    //canvasStyle.height = newWidth + 'px';
    canvasStyle.width = '100%';
    canvasStyle.height = '100%';
    // Center canvas
    //canvasStyle.marginTop = (windowHeight - newHeight) / 2;
    //canvasStyle.marginLeft = (windowWidth - newWidth) / 2;
  }

  function initUnits() {
    for (var i = 0; i < units.length; ++i) {
      var unit = units[i];
      var sprite = monkeymusic.sprites[unit.type]();
      sprite.gotoAndPlay('normal');
      sprite.x = monkeymusic.constants.UNIT_WIDTH * unit.x;
      sprite.y = monkeymusic.constants.UNIT_HEIGHT * unit.y;
      stage.addChild(sprite);
      unit.sprite = sprite;
    }
  }

  function updateUnits(newUnits) {
    _(units).each(function (oldUnit) {
      var newUnit = _(newUnits).find(function (unit) {
        return unit.id === oldUnit.id;
      });
      if (newUnit) {
        // Move unit
        if (newUnit.x !== oldUnit.x || newUnit.y !== oldUnit.y) {
          oldUnit.sprite.gotoAndPlay('run' + newUnit.facing || 'west');
          tween.get(oldUnit.sprite)
            .to({
              x: newUnit.x * monkeymusic.constants.UNIT_WIDTH,
              y: newUnit.y * monkeymusic.constants.UNIT_HEIGHT
            }, 800)
            .call(function () {
              oldUnit.sprite.gotoAndPlay('normal' + newUnit.facing || 'west');
            });
          oldUnit.x = newUnit.x;
          oldUnit.y = newUnit.y;
        }
      } else {
        stage.removeChild(oldUnit.sprite);
      }
    });
  }

  function init(canvas, level) {
    console.log(level);
    initStage(canvas, level);
    units = level.units;
    initUnits();
  }

  function update(level) {
    updateUnits(level.units);
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
