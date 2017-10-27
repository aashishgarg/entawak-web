function teamNotify(studentID) {
    App.student = App.cable.subscriptions.create({
        channel: "StudentChannel",
        student: studentID
    }, {
        received: function (data) {
            location.href = "/teams/" + data.team_id
        }
    });
}

