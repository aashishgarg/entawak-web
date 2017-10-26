function notify_start_game(questionID) {
    console.log(questionID);
    App.startGameChannel = App.cable.subscriptions.create({
        channel: "StartGameChannel",
        question: questionID
    }, {
        received: function (data) {
            console.log(this);
            $.ajax({
                url: '/questions/' + questionID,
                method: 'GET',
                dataType: 'script'
            })
        }
    });
}
