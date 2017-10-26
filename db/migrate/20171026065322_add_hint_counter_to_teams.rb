class AddHintCounterToTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :hint_counter, :integer, default: 4, after: :name
  end
end
