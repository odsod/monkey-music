var monkeymusic = monkeymusic || {};

monkeymusic.sprites = (function (createjs) {

  var SPRITE_SIZE = {
    width: monkeymusic.constants.UNIT_WIDTH,
    height: monkeymusic.constants.UNIT_HEIGHT
  };

  var sheets = {
    Monkey: (function () {
      var sheet = new createjs.SpriteSheet({
        images: ['assets/img/monkey.png'],
        frames: SPRITE_SIZE,
        animations: {
          run: [3, 5, 'run', 8],
          normal: [6, 7, 'normal', 48]
        }
      });
      //createjs.SpriteSheetUtils.addFlippedFrames(sheet, true, false, fa, falselse);
      return sheet;
    }()),
    Track: new createjs.SpriteSheet({
      images: ['assets/img/track.png'],
      frames: SPRITE_SIZE,
      animations: {
        normal: [0]
      }
    }),
    Basket: new createjs.SpriteSheet({
      images: ['assets/img/basket.png'],
      frames: SPRITE_SIZE,
      animations: {
        normal: [0]
      }
    })
  };

  function Monkey() {
    return new createjs.BitmapAnimation(sheets.Monkey);
  }

  function Track() {
    return new createjs.BitmapAnimation(sheets.Track);
  }

  function Basket() {
    return new createjs.BitmapAnimation(sheets.Basket);
  }

  return {
    Monkey: Monkey,
    Track: Track,
    Basket: Basket
  };

}(createjs));
