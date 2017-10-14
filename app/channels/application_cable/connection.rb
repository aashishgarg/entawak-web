module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_teacher

    def connect
      self.current_teacher = find_verified_teacher
    end

    private
    def find_verified_teacher
      if current_teacher = Teacher.find_by(id: cookies.signed[:teacher_id])
        current_teacher
      else
        reject_unauthorized_connection
      end
    end
  end
end
