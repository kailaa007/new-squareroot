class CreateChecklistAnswers < ActiveRecord::Migration
  def change
    create_table :checklist_answers do |t|
      t.string :title
      t.integer :user_id
      t.integer :checklist_id

      t.timestamps null: false
    end
  end
end
