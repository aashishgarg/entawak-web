//$(document).ready(function() {
//    $(window).bind('rails:flash', function(e, params) {
//        new PNotify({
//            title: params.type,
//            text: params.message,
//            type: params.type
//        });
//    });
//});
$(function () {
    // =============== Flash Notifications  =============== //
    $(window).bind('rails:flash', function (e, params) {
        new PNotify({
            text: params.message,
            type: params.type,
            delay: 5000,         // popup appears for this much time only.
            mouse_reset: false,
            nonblock: {         // allows to interact behind the popup.
                nonblock: true
            },
            buttons: {          // removes cross and other buttons from notification popup.
                sticker: false
            }
        });
    });
});