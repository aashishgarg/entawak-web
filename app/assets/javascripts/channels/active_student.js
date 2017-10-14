function studentNotify(teacherID) {
    App.activeStudent = App.cable.subscriptions.create({
        channel: "ActiveStudentChannel",
        room: teacherID
    }, {
        received: function (data) {
            return this.appendLine(data);
        },
        appendLine: function (data) {
            var html;
            html = this.createLine(data);
            return $("[data-chat-room='students']").append(html);
        },
        createLine: function (data) {
            // return "<article class=\"chat-line\">\n  <span class=\"speaker\">" + data + "</span>\n </article>";
            return "<div class='col-4'>" +
                "<div class='col-12 text-truncate'>" + data +
                "<i class='fa fa-times' aria-hidden='true'></i>" +
                "</div>" +
                "</div>";
        }
    });
}


