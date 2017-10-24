class Questionaire < ApplicationRecord

  #============== Associations =================
  belongs_to :team, inverse_of: :questionaire
  has_many :questions, inverse_of: :questionaire, dependent: :destroy

  #============== Nested attributes ============
  accepts_nested_attributes_for :questions

end
