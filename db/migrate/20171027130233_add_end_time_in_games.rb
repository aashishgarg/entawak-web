class AddEndTimeInGames < ActiveRecord::Migration[5.1]
  def change
    remove_column :games, :duration, :integer
    add_column  :games, :end_at, :datetime, after: :secret_knock
    add_column  :games, :pause_at, :datetime, after: :end_at
  end
end
