class Game < ApplicationRecord

  #============== Associations =================
  belongs_to :teacher, inverse_of: :games
  has_many :students, inverse_of: :game, dependent: :destroy
  has_many :teams, inverse_of: :game, dependent: :destroy
  has_many :results, inverse_of: :game

  #============== Callbacks =====================
  before_create :assign_secret_knock

  def assign_team_and_students
    if students.count >= 4
      teams.destroy_all
      Team::CLAN_NAME.take(students.count.div(4)).each {|clan| teams.create(name: clan)}
      students.zip(teams.cycle) do |student, team|
        student.update(team: team)
      end
    end
  end

  private

  def assign_secret_knock
    self.secret_knock = 6.times.map { rand(1..9) }.join.to_i
  end
end

