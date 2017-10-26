function teamNotify(studentID) {
    App.student = App.cable.subscriptions.create({
        channel: "StudentChannel",
        student: studentID
    }, {
        received: function (data) {
            console.log(data.team_id)
            location.href = "/teams/" + data.team_id
        }
    });
}
