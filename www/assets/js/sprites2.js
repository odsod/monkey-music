var monkeymusic = monkeymusic || {};

monkeymusic.sprites2 = (function(createjs, _) {

  var SPRITE_SIZE = {
    width: monkeymusic.constants.UNIT_WIDTH,
    height: monkeymusic.constants.UNIT_HEIGHT
  };

  var animationWithDirection = function(animationName, direction) {
    return animationName + direction;
  };

  var addDirectionAndOffset = function(frameData, direction, offset) {
    if (typeof frameData === 'number') {
      return frameData + offset;
    } else {
      frameData.frames = _(frameData.frames).map(function(frame) {
        return frame + offset;
      });
      if (frameData.next) {
        frameData.next = animationWithDirection(frameData.next, direction);
      }
      return frameData;
    }
  };

  var NpcSprite = (function() {
    var spriteSheet = new createjs.SpriteSheet({
      images: ['assets/sprites/npcs/sheet.png'],
      frames: SPRITE_SIZE,
      animations: {
        'Track1': 0,
        'Track2': 0,
        'Track3': 0,
        'Track-1': 0,
        'Track-2': 0,
        'Wall': 0,
        'User': 0
      }
    });
    return function() {
      this._spriteSheet = spriteSheet;
      this.initialize(spriteSheet);
    };
  }());

  NpcSprite.prototype = new createjs.BitmapAnimation();

  NpcSprite.prototype.forUnit = function(unit) {
    if (unit.type === 'Track') {
      this.shadow = new createjs.Shadow('#111', 4, 4, 8);
      this.gotoAndPlay('track' + unit.tier);
    } else if (this._spriteSheet[unit.type]) {
      this.gotoAndPlay(unit.type);
    }
  };

  var MonkeySprite = (function() {
    var animations = _({
      'normal': 0,
      'run': {
        frames: [1, 2, 0],
        next: 'run'
      }
    }).pairs()
      .map(function(pair) {
        return [
          [pair[0] + 'east', addDirectionAndOffset(pair[1], 'east', 0)],
          [pair[0] + 'west', addDirectionAndOffset(pair[1], 'west', 3)]
        ];
      })
      .flatten(1);
    var spriteSheets = _([
      'assets/sprites/monkeys/sheets/sheet.png',
      'assets/sprites/monkeys/sheets/sheet_30.png',
      'assets/sprites/monkeys/sheets/sheet_150.png',
      'assets/sprites/monkeys/sheets/sheet_70.png'
    ]).map(function(sheetImage) {
        return new createjs.SpriteSheet({
          images: [sheetImage],
          frames: SPRITE_SIZE,
          animations: animations
        });
      });
    var currSheet = 0;
    return function() {
      this.initialize(spriteSheets[currSheet]);
      currSheet = (currSheet + 1) % spriteSheets.length;
    };
  }());

  MonkeySprite.prototype = new createjs.BitmapAnimation();

  MonkeySprite.prototype.face = function(direction) {
    this._direction = direction;
    this.gotoAndPlay(this._animation);
    return this;
  };

  MonkeySprite.prototype.gotoAndPlay = function(animation) {
    this._animation = animation;
    this.prototype.gotoAndPlay(animationWithDirection(animation, this._direction));
    return this;
  };

  return {
    MonkeySprite: MonkeySprite,
    NpcSprite: NpcSprite
  };

}(createjs, _));
