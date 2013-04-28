(function ($) {

  var NAMESPACE = 'monkeyMusic';

  function initialize(level) {
    var $this = $(this);
    // Calculate metrics
    var arenaWidth = $(window).innerWidth();
    var arenaHeight = $(window).innerHeight();
    var unitWidth = arenaWidth / level.width;
    var unitHeight = arenaHeight / level.height;
    // Initialize scoreboard
    var monkeys = $.grep(level.units, function (unit) {
      return unit.type && unit.type === 'Monkey';
    });
    console.log(monkeys);
    $('#scoreboard').html(Handlebars.templates.scores(monkeys));
    // Place units
    //$.each(level.units, function (i, unit) {
      //var
        //$unit = $('<div />');
      //$unit
        //.addClass(unit.type.toLowerCase())
        //.addClass('unit')
        //.css({
          //left: unit.x * unitWidth,
          //top: unit.y * unitHeight,
          //width: unitWidth,
          //height: unitHeight,
          //'line-height': unitHeight + 'px'
        //})
        //.data('id', unit.id)
        //.appendTo($this);
      //unit.domElement = $unit;
    //});
    $this.data(NAMESPACE, {
      arenaWidth: arenaWidth,
      arenaHeight: arenaHeight,
      unitWidth: unitWidth,
      unitHeight: unitHeight,
      units: level.units
    });
  }

  function update(level) {
    var
      $this = $(this),
      data = $this.data(NAMESPACE);
    $.each(data.units, function (i, oldUnit) {
      var
        $unit = oldUnit.domElement,
        newUnit = $.grep(level.units, function (unit) {
          return unit.id === oldUnit.id;
        })[0];
      if (newUnit) {
        $unit.animate({
          left: newUnit.x * data.unitWidth,
          top: newUnit.y * data.unitHeight
        }, 700);
      } else {
        $unit.fadeOut(500, function () {
          $unit.remove();
        });
      }
    });
  }

  var methods = {
    init: function (options) {
      return this.each(function () {
        var data = $(this).data(NAMESPACE);
        if (!data) { // Has not been initialized
          console.log('initializing');
          initialize.call(this, options.level);
        }
      });
    },
    update: function (level) {
      return this.each(function () {
        var data = $(this).data(NAMESPACE);
        if (data) { // Has been initialized
          update.call(this, level);
        }
      });
    },
    destroy: function () {
      return this.each(function () {
        var
          $this = $(this),
          data = $this.data(NAMESPACE);
        $this.empty();
        $(window).unbind('.' + NAMESPACE);
        $this.removeData(NAMESPACE);
      });
    }
  };

  $.fn[NAMESPACE] = function (method) {
    if (methods[method]) {
      return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof method === 'object' || !method) {
      return methods.init.apply(this, arguments);
    } else {
      $.error('Method ' + method + ' does not exist on jQuery.' + NAMESPACE);
    }
  };

}(jQuery));
