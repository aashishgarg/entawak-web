class GameTemplate < ApplicationRecord

  #============== Associations =================
  has_many :games, inverse_of: :game_template, dependent: :destroy

end
