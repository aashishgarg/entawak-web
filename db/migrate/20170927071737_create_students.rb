class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.references :team
      t.references :game
      t.string :name
      t.timestamps
    end
  end
end
