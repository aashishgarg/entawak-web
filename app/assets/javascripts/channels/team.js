function startGame(teamID) {
    App.student = App.cable.subscriptions.create({
        channel: "TeamChannel",
        game: teamID
    }, {
        received: function (data) {
            if (data['team']) {
                location.href = '/teams/' + data['team'].id + '/question'
            }
        }
    });
}