$('document').ready(function() {

    var holidays_json = JSON.parse($('#calendar').attr('holidays'));
    $('#calendar').fullCalendar(
    {
        events: holidays_json,
        eventClick: function (event) {
            if (event.url) {
                window.location.href(event.url);
                return false;
            }
        }
    });


});
