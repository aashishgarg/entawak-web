class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_#{params[:game]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    puts "---------game received---------#{data}"
    ActionCable.server.broadcast(current_game, data)
  end
end
