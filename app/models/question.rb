class Question < ApplicationRecord

  #============== Associations =================
  belongs_to :questionaire, inverse_of: :questions

  #============== Validations ==================
  validates :questionaire, presence: true

  def move_to_next_question
    ActionCable.server.broadcast "game_#{}", name
    ActionCable.server.broadcast "team_#{}", name
  end

end
