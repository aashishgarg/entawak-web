function studentNotify(gameID) {
    App.gameChannel = App.cable.subscriptions.create({
        channel: "GameChannel",
        room: gameID
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
            return "<div class='col-4'>" +
                "<div class='col-12 text-truncate'>" + data +
                "<i class='fa fa-times' aria-hidden='true'></i>" +
                "</div>" +
                "</div>";
        }
    });
}


