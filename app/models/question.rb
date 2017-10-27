class Question < ApplicationRecord

  #============== Associations =================
  belongs_to :questionaire, inverse_of: :questions

  #============== Validations ==================
  validates :questionaire, presence: true

  #====== Store ======================================================
  store :serialized_options, accessors: [:options], coder: Hash

end
