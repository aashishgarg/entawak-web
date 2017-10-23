class AddSecretKnockToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :secret_knock, :integer, limit: 6, after: :name
    add_column :games, :duration, :integer, after: :secret_knock
    add_column :games, :missing_devices, :integer, after: :duration
  end
end
