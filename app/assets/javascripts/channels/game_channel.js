function studentNotify(gameId) {
    App.game = App.cable.subscriptions.create({
        channel: "GameChannel",
        game: gameId
    }, {
        received: function (data) {
            if (data['game']) {
                $.ajax({
                    type: "GET",
                    dataType: "script",
                    url: '/games/' + data['game'].id + '/active_students',
                    success: function (data) {
                    }
                });
            } else {

            }
        }
    });
}

function gameState(gameId) {
    App.game = App.cable.subscriptions.create({
        channel: "GameChannel",
        game: gameId
    }, {
        received: function (data) {
            if (data['pause']) {
                location.href = '/games/' + data['pause'].id + '/pause'
            }
        }
    });
}

