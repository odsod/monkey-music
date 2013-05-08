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
    User: new createjs.SpriteSheet({
      images: ['assets/img/basket.png'],
      frames: SPRITE_SIZE,
      animations: {
        normal: [0]
      }
    })
  };

  return {
    Monkey: function () { return new createjs.BitmapAnimation(sheets.Monkey); },
    Track: function () { return new createjs.BitmapAnimation(sheets.Track); },
    Wall: function () { return new createjs.BitmapAnimation(sheets.Wall); },
    User: function () { return new createjs.BitmapAnimation(sheets.User); }
  };

}(createjs));
