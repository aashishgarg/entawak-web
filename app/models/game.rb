class Game < ApplicationRecord

  #============== Associations =================
  belongs_to :teacher, inverse_of: :games
  has_many :students, inverse_of: :game, dependent: :destroy
  has_many :teams, inverse_of: :game, dependent: :destroy
  has_many :results, inverse_of: :game

  #============== Callbacks =================
  before_create :assign_secret_knock

  private

  def assign_secret_knock
    self.secret_knock = (SecureRandom.random_number(9e5) + 1e5).to_i
  end
end
