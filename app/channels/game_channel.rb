class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_#{params[:room]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast(current_game, data)
  end
end