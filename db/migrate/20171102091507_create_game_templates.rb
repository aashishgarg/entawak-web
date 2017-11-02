class CreateGameTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table :game_templates do |t|
      t.string :name
      t.string :subject
      t.string :level

      t.timestamps
    end
  end
end
