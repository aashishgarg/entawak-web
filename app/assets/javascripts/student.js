function populate_answer() {
    $('.select_option').on('change', function () {
        var answer = [];
        $.each($('.select_option'), function (index, element) {
            answer[parseInt($(element).data('index'))] = $(element).val();
        });
        $('.answer').val(answer.join(''));
    });
}