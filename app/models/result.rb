class Result < ApplicationRecord

  #============== Associations =================
  belongs_to :team, inverse_of: :results
  belongs_to :game, inverse_of: :results

end
