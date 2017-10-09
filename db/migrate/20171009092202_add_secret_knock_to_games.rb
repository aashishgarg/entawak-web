class AddSecretKnockToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :secret_knock, :string
  end
end
