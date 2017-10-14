class ActiveStudentChannel < ApplicationCable::Channel
  def subscribed
    stream_from "teacher_#{params[:room]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast(current_teacher, data)
  end
end
