class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.references :teacher
      t.string :name
      t.timestamps
    end
  end
end
