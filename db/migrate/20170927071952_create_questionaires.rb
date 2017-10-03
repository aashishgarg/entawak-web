class CreateQuestionaires < ActiveRecord::Migration[5.1]
  def change
    create_table :questionaires do |t|
      t.references :team
      t.string :name
      t.timestamps
    end
  end
end
