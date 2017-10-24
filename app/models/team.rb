class Team < ApplicationRecord

  #============== Constants ====================
  CLAN_NAMES = %w(red yellow green blue purple pink)

  #============== Associations =================
  belongs_to :game, inverse_of: :teams
  has_many :students, inverse_of: :team
  has_one :questionaire, inverse_of: :team
  has_many :results, inverse_of: :team

  #============== Validations ==================
  validates :game, presence: true

end
