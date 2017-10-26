function teamNotify11(studentID) {
    App.team = App.cable.subscriptions.create({
        channel: "TeamChannel",
        game: studentID
    }, {
        received: function (data) {
            console.log(data.id)
            // location.href = "/teams/" + data.team_id
        }
    });
}