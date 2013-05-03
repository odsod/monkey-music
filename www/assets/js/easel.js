(function (createjs, tween) {

  var
    canvas,
    stage,
    circle;

  var
    width = 14,
    height = 10,
    unitWidth = 70,
    unitHeight = 70,
    gameWidth = width * unitWidth,
    gameHeight = height * unitHeight;

  function resizeCanvas() {
    canvas.width = gameWidth;
    canvas.height = gameHeight;
    var
      windowWidth = window.innerWidth,
      windowHeight = window.innerHeight,
      scaleToFitX = windowWidth / gameWidth,
      scaleToFitY = windowHeight / gameHeight,
      optimalRatio = Math.min(scaleToFitX, scaleToFitY);
    canvas.style.width = gameWidth * optimalRatio + 'px';
    canvas.style.height = gameHeight * optimalRatio + 'px';
  }

  function init() {
    canvas = document.getElementById('canvas');
    createjs.Ticker.setFPS(60);
    createjs.useRAF = true;
    stage = new createjs.Stage(canvas);
    createjs.Ticker.addEventListener('tick', stage);
    var sprite = {
      images: ['assets/img/monkey.png'],
      frames: {
        width: 70,
        height: 70
      },
      animations: {
        run: [3, 5, 'run', 8],
        stand: [6, 7]
      }
    };
    var monkey = new createjs.SpriteSheet(sprite);
    var animation = new createjs.BitmapAnimation(monkey);
    stage.addChild(animation);
    animation.gotoAndPlay('run');
    tween.get(animation).to({
      x: 300
    }, 2000);
    resizeCanvas();
  }

  window.onresize = resizeCanvas;
  window.init = init;

}(createjs, createjs.Tween));
