class Student < ApplicationRecord

  #============== Associations =================
  belongs_to :game, inverse_of: :students
  belongs_to :team, inverse_of: :students, optional: :true

  #============== Validations ==================
  validates :game, presence: true
  validates :name, presence: true

  #============== Callbacks ====================
  after_create_commit :notify_teacher

  private

  def notify_teacher
    ActionCable.server.broadcast "game_#{game.id}", {'game' => self.game}
  end

end
