function teamNotify(studentID) {
    App.student = App.cable.subscriptions.create({
        channel: "StudentChannel",
        student: studentID
    }, {
        received: function (data) {
            if (data['team']) {
                location.href = "/teams"
            } else if (data['destroy']) {
                location.href = '/students/welcome'
            }
            else if (data['time_up']) {
                location.href = '/students/time_up'
            }
            else if (data['game_over']) {
                location.href = '/teams/game_over'
            }
        }
    });
}

