class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.references :game
      t.string :name

      t.timestamps
    end
  end
end
