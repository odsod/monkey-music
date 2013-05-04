var monkeymusic = monkeymusic || {};

monkeymusic.sprites = (function (createjs) {

  var SPRITE_SIZE = {
    width: monkeymusic.constants.UNIT_WIDTH,
    height: monkeymusic.constants.UNIT_HEIGHT
  };

  var sheets = {
    Monkey: new createjs.SpriteSheet({
      images: ['assets/img/monkey.png'],
      frames: SPRITE_SIZE,
      animations: {
        run: [3, 5, 'run', 8],
        stand: [6, 7, 'stand', 16]
      }
    }),
    Track: new createjs.SpriteSheet({
      images: ['assets/img/track.png'],
      frames: SPRITE_SIZE,
      animations: {
        default: [0]
      }
    }),
    Basket: new createjs.SpriteSheet({
      images: ['assets/img/basket.png'],
      frames: SPRITE_SIZE,
      animations: {
        default: [0]
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
