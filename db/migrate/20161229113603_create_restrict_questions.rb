class CreateRestrictQuestions < ActiveRecord::Migration
  def change
    create_table :restrict_questions do |t|
      t.integer :main_ques_id
      t.integer :base_ques_id
      t.boolean :status
      t.timestamps null: false
    end
  end
end
