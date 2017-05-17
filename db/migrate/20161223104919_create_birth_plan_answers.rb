class CreateBirthPlanAnswers < ActiveRecord::Migration
  def change
    create_table :birth_plan_answers do |t|
      t.integer :user_id
      t.string :question
      t.integer :ques_type
      t.text :answer
      t.timestamps null: false
    end
  end
end
