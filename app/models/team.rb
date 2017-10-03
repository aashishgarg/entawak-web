class Team < ApplicationRecord

  #============== Associations =================
  has_many :students, inverse_of: :team, dependent: :destroy
  has_one :questionaire, inverse_of: :team
  belongs_to :game, inverse_of: :teams
  has_many :results,inverse_of: :team

end
