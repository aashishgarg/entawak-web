class Question < ApplicationRecord

  #============== Associations =================
  belongs_to :questionaire, inverse_of: :questions

  #============== Validations ==================
  validates :questionaire, presence: true

  def move_to_next_question
    ActionCable.server.broadcast "game_#{id}", name
    ActionCable.server.broadcast "team_#{id}", name
  end

end
