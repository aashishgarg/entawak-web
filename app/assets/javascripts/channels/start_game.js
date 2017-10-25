function notify_start_game(gameID) {
    console.log(gameID);
    App.startGameChannel = App.cable.subscriptions.create({
        channel: "StartGameChannel",
        room: gameID
    }, {
        received: function (data) {
            console.log(this);
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
