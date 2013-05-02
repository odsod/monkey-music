(function ($) {

  var NAMESPACE = 'monkeyMusicLevel';

  function placeUnits(units, unitWidth, unitHeight) {
    $.each(units, function (i, unit) {
      unit.$el.css({
        left: unit.x * unitWidth,
        top: unit.y * unitWidth
      });
      unit.$el.addClass(unit.type + '-standing-sprite unit');
      unit.$el.sprite({ fps: 2, no_of_frames: 2 });
    });
  }

  function initialize(level) {
    // Calculate metrics
    var
      self = this,
      totalWidth = $(window).innerWidth(),
      totalHeight = $(window).innerHeight(),
      unitWidth = totalWidth / level.width,
      unitHeight = totalHeight / level.height;
    //Place units
    var unitTemplate = Handlebars.templates.units({
      units: level.units
    });
    this.html(unitTemplate);
    // Create unit-DOM mapping
    $.each(level.units, function (i, unit) {
      unit.$el = self.find('[data-id=\'' + unit.id + '\']');
    });
    // Place units on the level
    placeUnits(level.units, unitWidth, unitHeight);
    this.data(NAMESPACE, {
      totalWidth: totalWidth,
      totalHeight: totalHeight,
      unitWidth: unitWidth,
      unitHeight: unitHeight,
      units: level.units
    });
  }

  function update(level) {
  }

  var methods = {
    init: function (level) {
      return this.each(function () {
        var
          $this = $(this),
          data = $this.data(NAMESPACE);
        if (!data) { // Has not been initialized
          console.log('initializing ' + NAMESPACE);
          $this.data(NAMESPACE, {});
          initialize.call($this, level);
        } else {
          console.log('updating ' + NAMESPACE);
          update.call($this, level);
        }
      });
    },
    destroy: function () {
      return this.each(function () {
        $(this)
          .empty()
          .removeData(NAMESPACE);
        $(window).unbind('.' + NAMESPACE);
      });
    }
  };

  $.fn[NAMESPACE] = function (arg) {
    if (methods[arg]) {
      return methods[arg].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof arg === 'object' || !arg) {
      return methods.init.apply(this, arguments);
    } else {
      $.error('Method ' + arg + ' does not exist on jQuery.' + NAMESPACE);
    }
  };

}(jQuery));
