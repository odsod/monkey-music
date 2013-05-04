var monkeymusic = monkeymusic || {};

monkeymusic.sprites = (function (createjs) {

  var SPRITE_SIZE = {
    width: monkeymusic.constants.UNIT_WIDTH,
    height: monkeymusic.constants.UNIT_HEIGHT
  };

  var sheets = {
    Monkey: (function () {
      return new createjs.SpriteSheet({
        images: ['assets/img/monkey.png'],
        frames: SPRITE_SIZE,
        animations: {
          run: [3, 5, 'run', 8],
          stand: [6, 7, 'stand', 16]
        }
      });
    }())
  };

  function Monkey() {
    return new createjs.BitmapAnimation(sheets.Monkey);
  }

  return {
    Monkey: Monkey
  };
}(createjs));
