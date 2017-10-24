module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_game

    def connect
      self.current_game = find_verified_game
    end

    private
    def find_verified_game
      if current_teacher = Game.find_by(id: cookies.signed[:game_id])
        current_teacher
      else
        reject_unauthorized_connection
      end
    end
  end
end
