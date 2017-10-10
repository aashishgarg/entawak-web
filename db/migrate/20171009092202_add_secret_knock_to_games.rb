class AddSecretKnockToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :secret_knock, :integer, limit: 6
    add_column :games, :duration, :integer
    add_column :games, :missing_devices, :integer
  end
end
