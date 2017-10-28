class AddStatusToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :status, :boolean, default: true, after: :state
  end
end