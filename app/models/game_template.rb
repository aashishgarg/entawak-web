class GameTemplate < ApplicationRecord

  #============== Constants  ===================
  NAMES = %w(the_invansion)

  #============== Associations =================
  has_many :games, inverse_of: :game_template, dependent: :destroy

  #============== Paperclips ===================
  has_attached_file :avatar
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_attached_file :clue_sheet
  # validates_attachment_content_type :attachment, content_type: ['image/jpeg', 'image/png', 'application/pdf']

end
