(function ($) {

  var NAMESPACE = 'scoreboard';

  function initialize(state) {
    var self = this,
        scores = [];
    this.html(Handlebars.templates.scores(state));
    $.each(state.players, function (i, player) {
      var $el = self.find('[data-id=\'' + player.id + '\']');
      scores[player.id] = {
        $el: $el
      };
    });
    this.data(NAMESPACE, scores);
  }

  function update(state) {
    var data = this.data(NAMESPACE);
    _(data).each(function (score, id) {
      var player = _(state.players).find(function (player) {
        return player.id === id;
      });
      score.$el.tickTo(player.score);
    });
    this.find('.turn').tickTo(state.turn);
  }

  var methods = {
    init: function (state) {
      return this.each(function () {
        var
          $this = $(this),
          data = $this.data(NAMESPACE);
        if (!data) { // Has not been initialized
          console.log('initializing ' + NAMESPACE);
          $this.data(NAMESPACE, {});
          initialize.call($this, state);
        } else {
          console.log('updating ' + NAMESPACE);
          update.call($this, state);
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
