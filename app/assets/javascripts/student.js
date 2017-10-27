function populate_answer() {
    $('.main_container').find('.answer').val('');
    $('.main_container').on('change', '.select_option', function () {
        show_prepopulated_field()
    });
}

function play_pause_audio() {
    $('.teams_container').find('.play_pause').on('click', function () {
        aud_play_pause()
    });

    function aud_play_pause() {
        var myAudio = document.getElementById('audio');
        if (myAudio.paused) {
            $('.teams_container').find('#stateicon').removeClass('fa fa-play-circle');
            $('.teams_container').find('#stateicon').addClass('fa fa-pause-circle');
            myAudio.play();
        } else {
            $('.teams_container').find('#stateicon').removeClass('fa fa-pause-circle');
            $('.teams_container').find('#stateicon').addClass('fa fa-play-circle');
            myAudio.pause();
        }
    }
}

function show_prepopulated_field() {
    var answer = [];
    $.each($('.main_container').find('.select_option'), function (index, element) {
        console.log($(element).val());
        answer[parseInt($(element).data('index')) || index] = $(element).val();
    });
    $('.main_container').find('.answer').val(answer.join(''));
}
