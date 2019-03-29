define('modules/app/jquery.scroll', function(require, exports, module) {

  (function($) {
      $.fn.extend({
          /*
            opt = {
              up,
              down,
              line,
              speed,
              timer,
            }
          }
          */
          Scroll: function(opt, callback) {
              if (!opt) var opt = {};
              var _btnUp = $("#" + opt.up);
              var _btnDown = $("#" + opt.down);
              var timerID;
              var _this = this.eq(0).find("ul:first");
              var lineH = _this.find("li:first").height(),
                  line = opt.line ? parseInt(opt.line, 10) : parseInt(this.height() / lineH, 10),
                  speed = opt.speed ? parseInt(opt.speed, 10) : 500,
                  timer = opt.timer;
  
              if (line == 0) line = 1;
              var upHeight = 0 - line * lineH;
  
              var scrollUp = function() {
                  _btnUp.unbind("click", scrollUp);
                  _this.animate({
                      marginTop: upHeight
                  }, speed, function() {
                      for (i = 1; i <= line; i++) {
                          _this.find("li:first").appendTo(_this);
                      }
                      _this.css({
                          marginTop: 0
                      });
                      _btnUp.bind("click", scrollUp);
                  });
  
              };
  
              var scrollDown = function() {
                  _btnDown.unbind("click", scrollDown);
                  for (i = 1; i <= line; i++) {
                      _this.find("li:last").show().prependTo(_this);
                  }
                  _this.css({
                      marginTop: upHeight
                  });
                  _this.animate({
                      marginTop: 0
                  }, speed, function() {
                      _btnDown.bind("click", scrollDown);
                  });
              };
  
              var autoPlay = function() {
                  if (timer) timerID = window.setInterval(scrollUp, timer);
              };
  
              var autoStop = function() {
                  if (timer) window.clearInterval(timerID);
              };
              
              _this.hover(autoStop, autoPlay).mouseout();
              _btnUp.css("cursor", "pointer").click(scrollUp).hover(autoStop, autoPlay);
              _btnDown.css("cursor", "pointer").click(scrollDown).hover(autoStop, autoPlay);
          }
      })
  })(jQuery);
  

});
