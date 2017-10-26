class TeamChannel < ApplicationCable::Channel
  def subscribed
    stream_from "team_#{params[:game]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    puts "---------team received---------#{data}"
    ActionCable.server.broadcast(current_game, data)
  end
end
