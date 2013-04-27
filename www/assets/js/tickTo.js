(function ($) {

  $.fn.tickTo = function (newValue, totalInterval) {
    return this.each(function () {
      var
        $this = $(this),
        currValue = parseInt($this.text(), 10);
      if (isNaN(currValue)) {
        $this.text('0');
        currValue = 0;
      }
      var
        diff = newValue - currValue,
        interval = (totalInterval || 300) / Math.abs(diff),
        tickSign = diff / Math.abs(diff);
      var doTick = function () {
        if (currValue !== newValue) {
          currValue += tickSign;
          $this.text(currValue);
          setTimeout(doTick, interval);
        }
      };
      doTick();
    });
  };

}(jQuery));
