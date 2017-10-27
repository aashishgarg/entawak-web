class AddEndTimeInGames < ActiveRecord::Migration[5.1]
  def change
    remove_column :games, :duration
    add_column  :games, :end_time, :datetime, after: :secret_knock
  end
end
