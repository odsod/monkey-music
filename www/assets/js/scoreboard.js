(function ($) {

  var NAMESPACE = 'scoreboard';

  function grepMonkeys(units) {
    return $.grep(units, function (unit) {
      return unit.type && unit.type === 'Monkey';
    });
  }

  function initialize(level) {
    var
      self = this,
      monkeys = grepMonkeys(level.units),
      scores = [];
    this.html(Handlebars.templates.scores(monkeys));
    $.each(monkeys, function (i, monkey) {
      console.log('HEHEH');
      var $el = self.find('[data-id=\'' + monkey.id + '\']');
      console.log($el);
      scores[monkey.id] = {
        $el: $el
      };
    });
    this.data(NAMESPACE, scores);
  }

  function update(level) {
    var
      monkeys = grepMonkeys(level.units),
      data = this.data(NAMESPACE);
    _(data).each(function (score, id) {
      var monkey = _(monkeys).find(function (monkey) {
        return monkey.id === id;
      });
      console.log('MONKEY:');
      console.log(monkey);
      score.$el.tickTo(monkey.score);
    });
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
