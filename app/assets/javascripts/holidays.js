$('document').ready(function() {

        $('#calendar').fullCalendar(
        {
            events: $(this).attr('holidays'),
            eventClick: function (event) {
                if (event.url) {
                    window.location.href(event.url);
                    return false;
                }
            }
        });

});
