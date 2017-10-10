class Student < ApplicationRecord
  belongs_to :game, inverse_of: :students
  belongs_to :team, inverse_of: :students
end
