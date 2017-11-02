class GameTemplate < ApplicationRecord

  #============== Constants  ===================
  NAMES = %w(the_vampire the_cave dr._mittens mr._roboto)

  #============== Associations =================
  has_many :games, inverse_of: :game_template, dependent: :destroy

  #============== Associations =================
  has_attached_file :avatar
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

end
