class Teacher < ApplicationRecord

  #============== Devise configs ===============
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  #============== Associations =================
  has_many :games, inverse_of: :teacher, dependent: :destroy


  def notify_start_game(game)
    # game.teams.each {|team| team.students.each {|student| ActionCable.server.broadcast "start_game_#{game.id}", student.team.questions.first.id
    # }}
  end

end
