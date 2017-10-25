class StartGameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "start_game_#{params[:question]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast(current_game, data)
  end
end
