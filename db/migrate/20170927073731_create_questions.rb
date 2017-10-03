class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.references :questionaire
      t.string :question
      t.string :answer
      t.string :hint
      t.string :type
      t.timestamps
    end
  end
end
