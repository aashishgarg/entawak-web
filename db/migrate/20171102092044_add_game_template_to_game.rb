class AddGameTemplateToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :game_template_id, :bigint, after: :teacher_id
  end
end
