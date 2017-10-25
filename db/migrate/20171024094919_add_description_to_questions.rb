class AddDescriptionToQuestions < ActiveRecord::Migration[5.1]
  def change
    rename_column :questions, :question, :statement
    rename_column :questions, :type, :category
    add_column :questions, :description, :string, after: :statement
  end
end
