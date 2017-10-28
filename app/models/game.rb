class Game < ApplicationRecord

  #============== Constants =====================
  DURATION = 30

  #============== Associations ==================
  belongs_to :teacher, inverse_of: :games
  has_many :students, inverse_of: :game, dependent: :destroy
  has_many :teams, inverse_of: :game, dependent: :destroy
  has_many :results, inverse_of: :game

  #============== Callbacks =====================
  before_create :assign_secret_knock

  #============== Validations ===================
  validates :teacher, presence: true

  # Rule are:
  # 1. Only is available when students count > 3
  # TODO: Please put down the other rules here
  def assign_team_and_students
    if students.count >= 4
      teams.destroy_all
      Team::CLAN_NAMES.take(students.count.div(4)).each {|clan_name| teams.create(name: clan_name)}
      students.zip(teams.cycle) do |student, team|
        student.update(team: team)
      end
    end
  end

  def broadcast_team
    students.each {|student| ActionCable.server.broadcast "student_#{student.id}", {student: student}} if teams.present?
  end

  def time_left
    if end_at && (end_at > Time.now)
      minutes = ((end_at - Time.now)/1.minutes).to_i
      seconds = (end_at - Time.now).modulo(60)
      {minutes: minutes, seconds: seconds.round}
    else
      {minutes: 0, seconds: 1}
    end
  end

  def completed
    students.each {|student| ActionCable.server.broadcast "student_#{student.id}", {time_up: student}}
    update(status: false)
  end

  private

  def assign_secret_knock
    self.secret_knock = 6.times.map {rand(1..9)}.join.to_i
  end
end

