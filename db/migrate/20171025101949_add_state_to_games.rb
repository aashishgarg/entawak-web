class AddStateToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :state, :boolean, default: true, after: :duration
  end
end
