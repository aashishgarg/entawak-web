class Student < ApplicationRecord
  belongs_to :team, inverse_of: :students
end
