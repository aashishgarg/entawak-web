class CreateResults < ActiveRecord::Migration[5.1]
  def change
    create_table :results do |t|
      t.references :game
      t.integer :team_id
      t.integer :score

      t.timestamps
    end
  end
end
