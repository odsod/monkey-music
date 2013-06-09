var monkeymusic = monkeymusic || {};

monkeymusic.sprites = (function(createjs) {

  var SPRITE_SIZE = {
    width: monkeymusic.constants.UNIT_WIDTH,
    height: monkeymusic.constants.UNIT_HEIGHT
  };

  var animations = {
    Track1normaleast: [2],
    Track2normaleast: [1],
    Track3normaleast: [0],
    TrackM1normaleast: [4],
    TrackM2normaleast: [3],
    Monkeynormaleast: [5],
    Wallnormaleast: [6],
    Usernormaleast: [7],
    Monkeysleepeast: [8, 12, 'Monkeysleepingeast', 16],
    Monkeysleepingeast: [13, 15, 'Monkeysleepingeast', 16],
    Monkeyrunningeast: [17, 19, 'Monkeyrunningeast', 4],
    Monkeypickeast: [20, 24, 'Monkeynormaleast', 16],
    Monkeydelivereast: [25, 29, 'Monkeynormaleast', 16],
    Track1normalwest: [32],
    Track2normalwest: [31],
    Track3normalwest: [30],
    TrackM1normalwest: [34],
    TrackM2normalwest: [33],
    Monkeynormalwest: [35],
    Wallnormalwest: [36],
    Usernormalwest: [37],
    Monkeysleepwest: [38, 42, 'Monkeysleepingwest', 16],
    Monkeysleepingwest: [43, 45, 'Monkeysleepingwest', 16],
    Monkeyrunningwest: [47, 49, 'Monkeyrunningwest', 4],
    Monkeypickwest: [50, 54, 'Monkeynormalwest', 16],
    Monkeydeliverwest: [55, 59, 'Monkeynormalwest', 16]
  };

  var sheets = {
    Sprites: new createjs.SpriteSheet({
      images: ['assets/img/sprites.png'],
      frames: SPRITE_SIZE,
      animations: animations
    }),
    Monkey2: (function() {
      var sheet = new createjs.SpriteSheet({
        images: ['assets/img/sprites2.png'],
        frames: SPRITE_SIZE,
        animations: animations
      });
      return sheet;
    }())
  };

  var monkeySprites = [
    new createjs.SpriteSheet({
      images: ['assets/img/sprites.png'],
      frames: SPRITE_SIZE,
      animations: animations
    }), new createjs.SpriteSheet({
      images: ['assets/img/sprites2.png'],
      frames: SPRITE_SIZE,
      animations: animations
    }), new createjs.SpriteSheet({
      images: ['assets/img/sprites3.png'],
      frames: SPRITE_SIZE,
      animations: animations
    })
  ];

  var m = 2;

  return {
    Monkey: function() { m = (m + 1) % 3; return new createjs.BitmapAnimation(monkeySprites[m]); },
    Track: function() { return new createjs.BitmapAnimation(sheets.Track); },
    Wall: function() { return new createjs.BitmapAnimation(sheets.Wall); },
    Sheet: function() { return new createjs.BitmapAnimation(sheets.Sprites); },
    User: function() { return new createjs.BitmapAnimation(sheets.User); },
    reset: function() { m = 2; }
  };

}(createjs));
