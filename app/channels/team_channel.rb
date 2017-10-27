class TeamChannel < ApplicationCable::Channel
  def subscribed
    stream_from "team_#{params[:game]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast("team_#{data['game']}", data)
  end
end
