function teamNotify(studentID) {
    App.student = App.cable.subscriptions.create({
        channel: "StudentChannel",
        student: studentID
    }, {
        received: function (data) {
            if (data['student']) {
                location.href = "/teams/" + data['student'].team_id
            } else if (data['destroy']) {
                location.href = '/students/welcome'
            }
        }
    });
}

