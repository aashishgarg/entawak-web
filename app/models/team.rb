class Team < ApplicationRecord

  #============== Constants ====================
  CLAN_NAME = ['red', 'yellow', 'green', 'blue', 'purple', 'pink']

  #============== Associations =================
  has_many :students, inverse_of: :team
  has_one :questionaire, inverse_of: :team
  belongs_to :game, inverse_of: :teams
  has_many :results, inverse_of: :team

end
