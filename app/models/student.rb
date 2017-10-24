class Student < ApplicationRecord

  #============== Associations =================
  belongs_to :game, inverse_of: :students
  belongs_to :team, inverse_of: :students, optional: :true

  #============== Callbacks ====================
  after_create_commit :notify_teacher

  private

  def notify_teacher
    ActionCable.server.broadcast "teacher_#{game.teacher_id}", name
  end
end
