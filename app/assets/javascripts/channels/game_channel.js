function studentNotify(gameId) {
    App.gameChannel = App.cable.subscriptions.create({
        channel: "GameChannel",
        game: gameId
    }, {
        received: function (data) {
            if (data['game']) {
                console.log('inside notify student');
                $.ajax({
                    type: "GET",
                    dataType: "script",
                    url: '/games/' + data['game'].id + '/active_students',
                    success: function (data) {
                    }
                });
            } else{

            }
        }
    });
}

