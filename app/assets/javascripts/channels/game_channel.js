function studentNotify(gameId) {
    App.gameChannel = App.cable.subscriptions.create({
        channel: "GameChannel",
        game: gameId
    }, {
        received: function (data) {
            console.log('inside notify student');
            console.log(data.id);
            $.ajax({
                type: "GET",
                dataType: "script",
                url: '/games/' + data.id + '/active_students',
                success: function (data) {
                }
            });
        }
    });
}

function startGame(gameID) {
    App.gameChannel = App.cable.subscriptions.create({
        channel: "GameChannel",
        game: gameID
    }, {
        received: function (data) {
            console.log('inside startGame ');
        }
    });
}
