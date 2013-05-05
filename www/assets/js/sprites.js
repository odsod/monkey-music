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
          normal: [0, 1, 'normal', 48],
          normalwest: [0, 1, 'normalwest', 48],
          laughwest: [2],
          runwest: [3, 5, 'runwest', 8],
          pickwest: [6, 7, 'pickwest', 16],
          normaleast: [8, 9, 'normaleast', 48],
          laugheast: [10],
          runeast: [11, 13, 'runeast', 8],
          pickeast: [14, 15, 'pickeast', 16],
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
    Wall: new createjs.SpriteSheet({
      images: ['assets/img/palm.png'],
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
