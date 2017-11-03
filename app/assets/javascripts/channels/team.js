function teamGame(teamID) {
    App.team = App.cable.subscriptions.create({
        channel: "TeamChannel",
        game: teamID
    }, {
        received: function (data) {
            if (data['team']) {
                location.href = '/teams/question'
            } else if (data['team_scream']) {
                $('.team_hint_' + data['team_scream'].id).html(data['team_scream'].hint_counter)
            }
        }
    });
}