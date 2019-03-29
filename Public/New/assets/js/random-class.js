(function ($) {
    "use strict";


    /*
    -------------------
    Ticker
    -------------------*/

    if ($('.random-data')
        .length) {
        setRandomClass();
        setInterval(function () {
            setRandomClass();
        }, 1000);

        function setRandomClass() {
            var dtBody = $(".random-data");
            var items = dtBody.find("td");
            var number = items.length;
            var random1 = Math.floor((Math.random() * number));
            var random2 = Math.floor((Math.random() * number));
            var random3 = Math.floor((Math.random() * number));
            var random4 = Math.floor((Math.random() * number));
            var random5 = Math.floor((Math.random() * number));
            var random6 = Math.floor((Math.random() * number));
            items.removeClass("text-danger");
            items.removeClass("text-success");
            items.eq(random1)
                .addClass("text-success");
            items.eq(random2)
                .addClass("text-danger");
            items.eq(random3)
                .addClass("text-success");
            items.eq(random4)
                .addClass("text-danger");
            items.eq(random5)
                .addClass("text-success");
            items.eq(random6)
                .addClass("text-danger");
        }
    }
})(jQuery);
