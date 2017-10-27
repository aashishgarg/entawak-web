function populate_answer() {
    $('.main_container').find('.answer').val('');
    $('.main_container').on('change','.select_option', function () {
        var answer = [];
        $.each($('.main_container').find('.select_option'), function (index, element) {
            console.log($(element).data('index'));
            answer[parseInt($(element).data('index')) || index] = $(element).val();
        });
        $('.main_container').find('.answer').val(answer.join(''));
    });
}