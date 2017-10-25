function teamNotify(studentID) {
    App.team = App.cable.subscriptions.create({
        channel: "TeamChannel",
        student: studentID
    }, {
        received: function (data) {
            console.log("/students/" + data + "/team");
            $.ajax({
                type: "GET",
                dataType: "script",
                url: "/students/" + data + "/team",
                success: function(data){}
            });

        }
    });
}