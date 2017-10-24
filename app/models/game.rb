class Game < ApplicationRecord

  #============== Associations ==================
  belongs_to :teacher, inverse_of: :games
  has_many :students, inverse_of: :game, dependent: :destroy
  has_many :teams, inverse_of: :game, dependent: :destroy
  has_many :results, inverse_of: :game

  #============== Callbacks =====================
  before_create :assign_secret_knock

  # Rule are:
  # 1. Only is available when students count > 3
  # TODO: Please put down the other rules here
  def assign_team_and_students
    return if students.count < 4

    teams.destroy_all
    Team::CLAN_NAMES.take(students.count.div(4)).each {|clan_name| teams.create(name: clan_name)}
    students.zip(teams.cycle) do |student, team|
      student.update(team: team)
    end
  end

  private

  def assign_secret_knock
    self.secret_knock = (SecureRandom.random_number(9e5) + 1e5).to_i
  end
end

