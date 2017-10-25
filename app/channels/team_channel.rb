class TeamChannel < ApplicationCable::Channel
  def subscribed
    stream_from "team_#{params[:student]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast(current_game, data)
  end
end
