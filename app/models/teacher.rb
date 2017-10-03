class Teacher < ApplicationRecord

  #============== Associations =================
  has_many :games, inverse_of: :teacher, dependent: :destroy
end
