var monkeymusic = monkeymusic || {};

monkeymusic.sprites2 = (function(createjs, _) {

  var SPRITE_SIZE = {
    width: monkeymusic.constants.UNIT_WIDTH,
    height: monkeymusic.constants.UNIT_HEIGHT
  };

  var animationWithDirection = function(animationName, direction) {
    return animationName + (direction || 'west');
  };

  var addDirectionAndOffset = function(frameData, direction, offset) {
    if (typeof frameData === 'number') {
      return frameData + offset;
    } else {
      var newFrameData = {};
      newFrameData.frequency = frameData.frequency;
      newFrameData.frames = _(frameData.frames).map(function(frame) {
        return frame + offset;
      });
      if (frameData.next) {
        newFrameData.next = animationWithDirection(frameData.next, direction);
      }
      return newFrameData;
    }
  };

  var NpcSprite = (function() {
    var spriteSheet = new createjs.SpriteSheet({
      images: ['assets/sprites/npcs/out/sheet.png'],
      frames: SPRITE_SIZE,
      animations: {
        'Wall': 0,
        'User': 1,
        'Track3': 2,
        'Track2': 3,
        'Track1': 4,
        'Track-2': 5,
        'Track-1': 6
      }
    });
    return function() {
      this._spriteSheet = spriteSheet;
      this.initialize(spriteSheet);
      return this;
    };
  }());

  NpcSprite.prototype = new createjs.BitmapAnimation();

  NpcSprite.prototype.forUnit = function(unit) {
    if (unit.type === 'Track') {
      this.shadow = new createjs.Shadow('#111', 4, 4, 8);
      this.gotoAndPlay('Track' + unit.tier);
    } else {
      this.gotoAndPlay(unit.type);
    }
    return this;
  };

  var MonkeySprite = (function() {
    var animations = _.chain({
      'normal': 0,
      'run': {
        frames: [1, 2, 0],
        next: 'run',
        frequency: 6
      }
    }).pairs()
      .map(function(pair) {
        return [
          [pair[0] + 'east', addDirectionAndOffset(pair[1], 'east', 0)],
          [pair[0] + 'west', addDirectionAndOffset(pair[1], 'west', 3)]
        ];
      })
      .flatten(true)
      .object()
      .value();
    console.log(animations);
    var spriteSheets = _([
      'assets/sprites/monkeys/out/sheet.png',
      'assets/sprites/monkeys/out/sheet_30.png',
      'assets/sprites/monkeys/out/sheet_150.png',
      'assets/sprites/monkeys/out/sheet_70.png'
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
      this.gotoAndPlayFacing('normal', 'east');
      currSheet = (currSheet + 1) % spriteSheets.length;
    };
  }());

  MonkeySprite.prototype = new createjs.BitmapAnimation();

  MonkeySprite.prototype.gotoAndPlayFacing = function(animation, direction) {
    this.gotoAndPlay(animationWithDirection(animation, direction));
  };

  return {
    MonkeySprite: MonkeySprite,
    NpcSprite: NpcSprite
  };

}(createjs, _));
