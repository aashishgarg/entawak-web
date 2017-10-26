function teamNotify(studentID) {
    App.team = App.cable.subscriptions.create({
        channel: "TeamChannel",
        student: studentID
    }, {
        received: function (data) {
            $.ajax({
                type: "GET",
                dataType: "script",
                url: "/students/" + data + "/team",
                success: function(data){}
            });

        }
    });
}