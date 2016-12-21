class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.integer :type
      t.text :note
      t.timestamps null: false
    end
  end
end
