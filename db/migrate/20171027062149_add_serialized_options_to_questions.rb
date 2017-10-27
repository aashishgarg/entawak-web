class AddSerializedOptionsToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :serialized_options, :text
  end
end
