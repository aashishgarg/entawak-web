class Question < ApplicationRecord

  #============== Associations =================
  belongs_to :questionaire, inverse_of: :questions

end
