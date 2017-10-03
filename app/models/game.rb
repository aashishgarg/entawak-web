class Game < ApplicationRecord

  #============== Associations =================
  belongs_to :teacher, inverse_of: :games
  has_many :teams, inverse_of: :game, dependent: :destroy
  has_many :results, inverse_of: :game


end
