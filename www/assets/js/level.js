var monkeymusic = monkeymusic || {};

monkeymusic.level = (function (createjs, tween, window) {

  /* Settings */
  createjs.Ticker.setFPS(60);
  createjs.useRAF = true;

  var
    stage,
    units;

  function init(canvas, level) {
    if (!stage) {
      // Initialize stage
      stage = new createjs.Stage(canvas);
      createjs.Ticker.addEventListener('tick', stage);
    }
    // Reset stage
    stage.removeAllChildren();
    stage.clear();
    // Initialize units
    _(level.units).each(function (unit) {
      var sprite = monkeymusic.sprites.Sheet();
      if (unit.type === 'Track') {
        sprite.gotoAndPlay('Track' + (unit.tier < 0 ? 'M' : '') + Math.abs(unit.tier) + 'normalwest');
        sprite.shadow = new createjs.Shadow('#999', 3, 3, 5);
      } else {
        sprite.gotoAndPlay(unit.type + 'normal' + (unit.facing || 'east'));
      }
      sprite.x = monkeymusic.constants.UNIT_WIDTH * unit.x;
      sprite.y = monkeymusic.constants.UNIT_HEIGHT * unit.y;
      stage.addChild(sprite);
      unit.sprite = sprite;
    });
    // Keep units in state
    units = level.units;
    // Set canvas dimensions
    canvas.width = level.width * monkeymusic.constants.UNIT_WIDTH;
    canvas.height = level.height * monkeymusic.constants.UNIT_HEIGHT;
    window.onresize = resizeCanvas;
    resizeCanvas();
  }

  function update(newLevel) {
    console.log(newLevel);
    _(units).each(function (unit) {
      var newUnit = _(newLevel.units).find(function (u) {
        return unit.id === u.id;
      });
      if (newUnit) {
        // Move unit
        if (newUnit.x !== unit.x || newUnit.y !== unit.y) {
          var animation = unit.type + 'running' + newUnit.facing || 'west';
          console.log('moving unit! ' + animation);
          unit.sprite.gotoAndPlay(animation);
          tween.get(unit.sprite)
            .to({
              x: newUnit.x * monkeymusic.constants.UNIT_WIDTH,
              y: newUnit.y * monkeymusic.constants.UNIT_HEIGHT
            }, 480)
            .call(function () {
              unit.sprite.gotoAndPlay(unit.type + 'normal' + newUnit.facing || 'west');
            });
          unit.x = newUnit.x;
          unit.y = newUnit.y;
        }
      } else {
        // Unit no longer exists on level, remove
        stage.removeChild(unit.sprite);
      }
    });
  }

  function destroy() {
    // Reset stage
    stage.removeAllChildren();
    stage.clear();
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

  return {
    init: init,
    update: update,
    destroy: destroy
  };

}(createjs, createjs.Tween, window));
