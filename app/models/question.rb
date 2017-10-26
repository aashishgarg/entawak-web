class Question < ApplicationRecord

  #============== Associations =================
  belongs_to :questionaire, inverse_of: :questions

  #============== Validations ==================
  validates :questionaire, presence: true

end
