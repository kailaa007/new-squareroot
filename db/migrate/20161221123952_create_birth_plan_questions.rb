class CreateBirthPlanQuestions < ActiveRecord::Migration
  def change
    create_table :birth_plan_questions do |t|
      t.references :birth_plan
      t.references :question
      t.timestamps null: false
    end
  end
end
