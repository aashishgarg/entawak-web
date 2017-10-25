class Question < ApplicationRecord
  belongs_to :questionaire, inverse_of: :questions
end
