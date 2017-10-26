class Team < ApplicationRecord

  #============== Constants ====================
  CLAN_NAMES = %w(red yellow green blue purple pink)

  #============== Associations =================
  belongs_to :game, inverse_of: :teams
  has_many :students, inverse_of: :team
  has_one :questionaire, inverse_of: :team
  has_many :results, inverse_of: :team
  has_many :questions, through: :questionaire

  #============== Validations ==================
  validates :game, presence: true

  #============= Callbacks =====================
  after_create :populate_questionaire


  private
  def populate_questionaire
    create_questionaire(name: name)
  end
end
